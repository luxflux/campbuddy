namespace :campplaner do
  desc 'Import the downloaded CSV'
  task import_users: :environment do
    users_file = ENV['USER_FILE_PATH']
    hostname = ENV['IMPORT_PICTURES_HOSTNAME']
    tenant = ENV['IMPORT_TENANT']

    raise 'You need to specify USER_FILE_PATH env variable' unless users_file
    raise 'You need to specify IMPORT_PICTURES_HOSTNAME env variable' unless hostname
    raise 'You need to specify IMPORT_TENANT env variable' unless tenant

    Apartment::Tenant.switch! tenant

    csv_file = File.open users_file
    CSV.foreach(csv_file, headers: true) do |row|
      email = row.field('email')
      picture_path = row.field('profilbild')
      birthday = row.field('birthday')

      begin
        birthday = Date.parse(birthday)
      rescue ArgumentError
        begin
          birthday = Date.strptime birthday, '%d.%m.%y'
        rescue ArgumentError
          birthday = Date.strptime birthday, '%m/%d/%y'
        end
      end

      cellphone = row.field('cellphone').try { gsub(/[^\d]/, '') }

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
end
