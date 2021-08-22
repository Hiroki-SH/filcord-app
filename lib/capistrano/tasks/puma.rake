namespace :puma do
  # task :environment do
  #   set :puma_pid, "#{current_path}/tmp/pids/server.pid"
  # end

  def start_puma
    within current_path do
      execute :bundle, :exec, :rails, :s, "-e #{fetch(:rails_env)}"
    end
  end

  def stop_puma
    execute :kill, "-2 $(<#{fetch(:puma_pid)})"
  end

  def reload_puma
    execute :kill, "-12 $(<#{fetch(:puma_pid)})"
  end

  desc "Start puma server"
  task :start do
    on roles(:app) do
      start_puma
    end
  end

  desc "Stop puma server normal"
  task :stop do
    on roles(:app) do
      stop_puma
    end
  end

  desc "Restart puma server"
  task :restart do
    on roles(:app) do
      if test("[ -f #{fetch(:puma_pid)} ]")
        reload_puma
      else
        start_puma
      end
    end
  end
end
