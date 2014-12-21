# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'campplaner'
set :repo_url, 'git@github.com:ICFMovement/camp-workshops.git'
set :deploy_to, '/srv/www/campplaner.yux.ch'

set :linked_files, -> { %W{config/database.yml config/secrets.yml} }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :keep_releases, 5

task :notify_rollbar do
  on roles(:app) do |h|
    revision = `git log -n 1 --pretty=format:"%H"`
    local_user = `whoami`
    rollbar_token = '12d291e5253a4c0dbc7fc20e66e5ba5a'
    rails_env = fetch(:rails_env, 'production')
    execute "curl -s -o /dev/null https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user}", :once => true
  end
end

after :deploy, 'notify_rollbar'
