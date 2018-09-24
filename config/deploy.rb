# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

set :application, "QAPlatformRails"
set :repo_url, "git@bitbucket.org:arjunthedragon/qa_platform_rails.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/apps/qa_platform_rails"

# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5


# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w[publickey],
  keys: %w[/home/arjun/dragon_server/dragon.pem]
}

set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')
set :passenger_restart_command, 'rvmsudo passenger-config restart-app'

# Don't generate binstubs by default ...
set :bundle_binstubs, nil

set :rvm_ruby_version, 'ruby-2.4.1@qa_platform'
set :passenger_restart_with_touch, true

namespace :deploy do
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end

      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

end