# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "filcord-app"
set :repo_url, "git@github.com:Hiroki-SH/filcord-app.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/rails/filcord-app/"

# rbenvの設定　
set :rbenv_type, :user
#サーバ上では、rbenvはホームディレクトリにインストールされているため。
# https://github.com/capistrano/rbenv/blob/master/lib/capistrano/tasks/rbenv.rake を参照
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# bundlerの設定
append :linked_dirs, '.bundle'
set :bundle_jobs, 1 #デフォルトでは4になっている。ec2インスタンスのCPUコア数に合わる。

#Railsの設定
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'
append :linked_files, 'config/master.key'

#yarnのパスを設定。
#https://stackoverflow.com/questions/61129932/why-does-capistrano-deployment-fail-at-assetsprecompile-without-error/61210930#61210930
set :default_env, {
  PATH: '$HOME/.nodenv/shims/:$PATH',
  NODE_ENVIRONMENT: 'production'
}

#pumaの設定
set :puma_pid, "#{current_path}/tmp/pids/server.pid"

namespace :deploy do

  after :publishing, :restart
  desc "Restart application"
  task :restart do
    invoke 'puma:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
