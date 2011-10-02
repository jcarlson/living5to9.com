Capistrano::Configuration.instance(:must_exist).load do

  namespace :dragonfly do
    desc "Symlink the Dragonfly's Rack::Cache files"
    task :symlink, :roles => [:app] do
      run "mkdir -p #{shared_path}/tmp/dragonfly && ln -nfs #{shared_path}/tmp/dragonfly #{release_path}/tmp/dragonfly"
    end
  end

  after 'deploy:update_code', 'dragonfly:symlink'

end