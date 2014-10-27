workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3001
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
        Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end

# application_path = '~/deploy/apps/prproject/current'
# railsenv = 'production'
# directory application_path
# environment railsenv
# daemonize true
# pidfile "#{application_path}/tmp/pids/puma.pid"
# state_path "#{application_path}/tmp/pids/puma.state"
# # stdout_redirect
# # "#{application_path}/log/puma.stdout.log",
# #     "#{application_path}/log/puma-#{railsenv}.stderr.log"
# threads 0, 16
# bind "unix://#{application_path}/tmp/sockets/puma.sock"