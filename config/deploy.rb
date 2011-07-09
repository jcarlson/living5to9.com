require 'bundler/capistrano'

# Application settings
set :application, "living5to9.com"

# SCM settings
set :scm, :git
set :repository,  "git@github.com:jcarlson/living5to9.com.git"
set :deploy_via, :remote_cache
set :branch, "master"

# Deployment settings
set :user, "jcarlson"
set :deploy_to, "/home/jcarlson/living5to9.com"
set :use_sudo, false

# Servers and services
role :web, "living5to9.com"                          # Your HTTP server, Apache/etc
role :app, "living5to9.com"                          # This may be the same as your `Web` server
role :db,  "living5to9.com", :primary => true     # This is where Rails migrations will run

# Additional settings
ssh_options[:forward_agent] = true

# Additional tasks
namespace :deploy do

  desc "start application server; no-op for Passenger"
  task :start do ; end

  desc "stop application server; no-op for Passenger"
  task :stop do ; end

  desc "restart application server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end

namespace :deploy do

  desc "installs Bundler if it is not already installed"
  task :install_bundler, :roles => :app do
    sudo "sh -c 'if [ -z `which bundle` ]; then echo Installing Bundler; gem install bundler; fi'"
  end

  desc "run 'bundle install' to install Bundler's packaged gems for the current deploy"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install --deployment --without development test"
  end

end

# attach tasks to lifecycle
before "deploy:bundle_install", "deploy:install_bundler"
after "deploy:update_code", "deploy:bundle_install"
