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

    desc "create shared directories"
    task :setup, :except => { :no_release => true } do
      run "mkdir -p #{shared_path}/uploads"
    end

    desc "symlink shared directories"
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    end

  end

  after "deploy:setup", "dreamhost:setup"
  after "deploy:finalize_update", "dreamhost:symlink"

end