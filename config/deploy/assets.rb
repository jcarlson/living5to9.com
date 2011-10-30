Capistrano::Configuration.instance(:must_exist).load do

  namespace :assets do
    
    desc "Clean any existing assets"
    task :clean, :roles => [:app] do
      system("rake assets:clean RAILS_ENV=production")
    end
    
    desc "Precompile assets for production locally"
    task :precompile, :roles => [:app] do
      system("bundle exec rake assets:precompile RAILS_GROUPS=assets RAILS_ENV=production")
    end
    
    desc "Prepare shared assets directory"
    task :symlink, :roles => [:app] do
      run "mkdir -p #{shared_path}/assets && ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    end
    
    desc "Upload locally compiled assets"
    task :deploy, :roles => [:app] do
      upload("public/assets", "#{shared_path}", :recursive => true, :via => :scp)
    end
    
  end

  after 'deploy:update_code', 'assets:clean'
  after 'deploy:update_code', 'assets:precompile'
  after 'deploy:update_code', 'assets:deploy'
  
  before 'assets:deploy', 'assets:symlink'

end