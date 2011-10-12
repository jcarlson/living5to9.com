Capistrano::Configuration.instance(:must_exist).load do

  namespace :dragonfly do
    desc "Symlink the Dragonfly's Rack::Cache files"
    task :symlink, :roles => [:app] do
      run "mkdir -p #{shared_path}/tmp/cache && ln -nfs #{shared_path}/tmp/cache #{release_path}/tmp/cache"
    end
  end

  after 'deploy:update_code', 'dragonfly:symlink'

end