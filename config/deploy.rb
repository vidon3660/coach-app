require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler
require "bundler/capistrano"


# General
set :application, "coach-app"
set :user, "michal"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy

set :use_sudo, false

# GIT
set :scm, :git
set :repository, "git@bitbucket.org:coachapp/coach-app.git"
set :branch, "release"

# VPS
role :web, "94.124.6.116"                          # Your HTTP server, Apache/etc
role :app, "94.124.6.116"                          # This may be the same as your `Web` server
role :db,  "94.124.6.116", :primary => true # This is where Rails migrations will run
role :db,  "94.124.6.116"

after "deploy:update_code","deploy:config_symlink"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :config_symlink do
    run "cp #{release_path}/config/database.yml.example #{release_path}/config/database.yml"
  end
end