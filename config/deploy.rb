# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'campplaner'
set :repo_url, 'git@github.com:ICFMovement/camp-workshops.git'
set :deploy_to, '/srv/www/campplaner.yux.ch'

set :linked_files, -> { %W{config/database.yml config/secrets.yml} }
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :keep_releases, 5


# namespace :deploy do

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end
