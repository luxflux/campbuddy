namespace :campplaner do
  desc 'Download a CSV from the users from wintercamp 2015 website'
  task download_users: :environment do
    mysql_host = ENV['IMPORT_HOST']
    mysql_user = ENV['IMPORT_USER']
    mysql_password = ENV['IMPORT_PASSWORD']
    mysql_database = ENV['IMPORT_DATABASE']
    mysql_table = ENV['IMPORT_TABLE']

    raise 'You need to specify IMPORT_HOST env variable' unless mysql_host
    raise 'You need to specify IMPORT_USER env variable' unless mysql_user
    raise 'You need to specify IMPORT_PASSWORD env variable' unless mysql_password
    raise 'You need to specify IMPORT_DATABASE env variable' unless mysql_database
    raise 'You need to specify IMPORT_TABLE env variable' unless mysql_table

    sql = "SELECT name, firstname, email, mobile AS cellphone, birthday, profilbild FROM #{mysql_table}"
    mysql_command = "mysql -h #{mysql_host} -u #{mysql_user} --password=#{mysql_password} #{mysql_database} -e '#{sql}'"
    awk = 'awk -F \\\t \'{print $1","$2","$3","$4","$5","$6}\''

    sh "#{mysql_command} | #{awk} > #{Rails.root.join('tmp/users.csv')}"
  end

  desc 'Import the downloaded CSV'
  task import_users: :download_users do
    hostname = ENV['IMPORT_PICTURES_HOSTNAME']
    tenant = ENV['IMPORT_TENANT']

    raise 'You need to specify IMPORT_PICTURES_HOSTNAME env variable' unless hostname
    raise 'You need to specify IMPORT_TENANT env variable' unless tenant

    Apartment::Tenant.switch! tenant

    csv_file = File.open Rails.root.join('tmp/users.csv')
    CSV.foreach(csv_file, headers: true) do |row|
      email = row.field('email')
      picture_path = row.field('profilbild')
      birthday = row.field('birthday')

      begin
        birthday = Date.parse(birthday)
      rescue ArgumentError
        birthday = Date.strptime birthday, '%d.%m.%y' rescue nil
      end

      cellphone = row.field('cellphone').split('/').first

      attributes = row.to_hash.slice(*%w(name firstname email))
      attributes[:password] = Kernel.rand
      attributes[:birthday] = birthday
      attributes[:cellphone] = cellphone

      begin
        user = User.where(email: email.downcase).first_or_create!(attributes)
        next unless user.avatar.uses_fallback?

        picture_extension = picture_path.split('.').last.downcase
        url = "http://#{hostname}/#{URI.escape(picture_path)}"
        uri = URI.parse(url)
        Net::HTTP.start(uri.host, uri.port) do |http|
          resp = http.get(uri.path)
          tmpfile = Tempfile.new(['picture-', ".#{picture_extension}"])
          tmpfile.binmode
          tmpfile.write(resp.body)
          tmpfile.flush

          resp = http.get(uri.path)
          user.avatar = tmpfile
          user.save!
          tmpfile.unlink
        end
      rescue => error
        $stderr.puts row.to_s
        $stderr.puts "  #{error.class}: #{error.message}"
        $stderr.puts ''
      end
    end
  end

  desc 'Regenerate all user avatars'
  task regenerate_avatars: :environment do
    User.find_each do |user|
      next unless user.avatar?
      user.avatar.recreate_versions!
      user.save!
    end
  end

  desc 'Regenerate all event impressions'
  task regenerate_impressions: :environment do
    Event.find_each do |event|
      next unless event.impression?
      event.impression.recreate_versions!
      event.save!
    end
  end

  task create_applications: :environment do
    paw = Doorkeeper::Application.where(name: 'Paw').first_or_create!(redirect_uri: 'urn:ietf:wg:oauth:2.0:oob', scopes: %w(read write))
    puts 'Paw'
    puts '---'
    puts "Client ID: #{paw.uid}"
    puts "Client Secret: #{paw.secret}"
    puts "Redirect URL: #{paw.redirect_uri}"
  end
end
