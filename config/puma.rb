bind 'tcp://0.0.0.0:7788'
threads 8, 32
workers 2
preload_app!
worker_timeout 30
daemonize
pidfile './tmp/pids/puma_dev.pid'
state_path './tmp/pids/puma_dev.state'
stdout_redirect './log/dev_stdout', './log/dev_stderr', true


on_worker_boot do
  # Valid on Rails 4.1+ using the `config/database.yml` method of setting `pool` size
  ActiveRecord::Base.establish_connection
end


before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end