set :application, "andr.esmejia.com"
role :app, "69.164.213.254"
role :web, "69.164.213.254"
role :db, "69.164.213.254", :primary => true

set :user, "esmejia"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:andmej/andr.esmejia.git"
set :branch, "master"

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  
  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Apache."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files and fill in #{shared_path}."
  end
end

after "deploy:setup", "deploy:setup_shared"
after "deploy:update_code", "deploy:symlink_extras"
