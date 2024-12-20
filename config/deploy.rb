# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "spectre"
set :repo_url, "git@github.com:oneharpal/spectre.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, "deploy"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/spectre"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"


# Set the Ruby version (example for rbenv)
set :rbenv_ruby, "3.3.5"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
# Puma settings

set :puma_threads, [ 4, 16 ]
set :puma_workers, 2
set :puma_preload_app, true
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_restart_command, "bundle exec puma -C config/puma.rb"
set :bundle_bins, fetch(:bundle_bins, []).push("rake")

# Run migrations automatically after deploy
after "deploy:updated", "deploy:migrate"

# After deployment tasks
namespace :deploy do
  task :restart_puma do
    on roles(:app) do
      execute :sudo, "systemctl", "restart", "puma"
    end
  end

  after :published, :restart_puma
end
