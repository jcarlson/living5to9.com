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
role :db,  "living5to9.com", :primary => true        # This is where Rails migrations will run

# Additional settings
ssh_options[:forward_agent] = true
set :rake, "bundle exec rake"

# Setup environment paths, etc...
set :default_environment, {
  'HOME' => "/home/jcarlson",
  'PATH' => "$HOME/local/bin:$HOME/.gems/bin:$PATH",
  'GEM_PATH' => "$HOME/.gems:/usr/local/lib/ruby/gems/1.8",
  'GEM_HOME' => "$HOME/.gems",
  'LDFLAGS' => "-L/$HOME/local/lib",
  'CPPFLAGS' => "-I/$HOME/local/include",
  'LD_RUN_PATH' => "$HOME/local/lib"
}

# Additional tasks
require 'bundler/capistrano'
require 'config/deploy/database'
require 'config/deploy/dragonfly'
require 'config/deploy/dreamhost'
require 'config/deploy/assets'