bind 'unix:///tmp/doctor_helper.sock'
threads 8, 32
workers 4
preload_app!
worker_timeout 30
daemonize
pidfile './tmp/pids/puma.pid'
state_path './tmp/pids/puma.state'
stdout_redirect './log/stdout', './log/stderr', true
environment 'production'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end