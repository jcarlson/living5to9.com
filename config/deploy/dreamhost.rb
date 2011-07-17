Capistrano::Configuration.instance(:must_exist).load do

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

  namespace :dreamhost do

    desc <<-DESC
      Creates the fog_credentials.yml configuration file in shared path.
    DESC
    task :setup, :except => { :no_release => true } do

      template = File.read fetch(:template_dir, "config/deploy") + '/fog_credentials.yml.erb'
      config = ERB.new(template)

      run "mkdir -p #{shared_path}/config"
      put config.result(binding), "#{shared_path}/config/fog_credentials.yml"
    end

    desc <<-DESC
      [internal] Updates the symlink for database.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/fog_credentials.yml #{release_path}/config/fog_credentials.yml"
    end

  end

  after "deploy:setup", "dreamhost:setup"
  after "deploy:finalize_update", "dreamhost:symlink"

end