namespace :campplaner do
  desc 'Download a CSV from the users from wintercamp 2015 website'
  task download_users: :environment do
    mysql_host = ENV['WC15_HOST']
    mysql_user = ENV['WC15_USER']
    mysql_password = ENV['WC15_PASSWORD']

    raise 'You need to specify WC15_HOST env variable' unless mysql_host
    raise 'You need to specify WC15_USER env variable' unless mysql_user
    raise 'You need to specify WC15_PASSWORD env variable' unless mysql_password

    sql = 'SELECT name, firstname, email, profilbild FROM wc15_users'
    mysql_command = "mysql -h #{mysql_host} -u #{mysql_user} --password=#{mysql_password} oneyouth -e '#{sql}'"
    awk = 'awk -F \\\t \'{print $1","$2","$3","$4}\''

    sh "#{mysql_command} | #{awk} > #{Rails.root.join('tmp/users.csv')}"
  end

  desc 'Import the downloaded CSV'
  task import_users: :download_users do
    csv_file = File.open Rails.root.join('tmp/users.csv')
    CSV.foreach(csv_file, headers: true) do |row|
      email = row.field('email')
      picture_path = row.field('profilbild')

      attributes = row.to_hash.slice(*%w(name firstname email))
      attributes[:password] = Kernel.rand

      begin
        user = User.where(email: email.downcase).first_or_create!(attributes)
        next unless user.avatar.uses_fallback?

        picture_extension = picture_path.split('.').last.downcase
        url = "http://wintercamp.oneyouth.ch/#{URI.escape(picture_path)}"
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
