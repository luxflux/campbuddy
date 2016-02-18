# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'campplaner'
set :repo_url, 'git@github.com:dev-kitchen/campbuddy.git'
set :deploy_to, '/srv/www/campplaner.yux.ch'

set :linked_files, -> { %W{config/database.yml config/secrets.yml} }
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads public/assets}

set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'

namespace :deploy do
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
