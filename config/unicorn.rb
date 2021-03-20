# frozen_string_literal: true

$worker = 2
$timeout = 30
# $app_dir = File.expand_path "../", __FILE__
$app_dir = '/electronote'
$listen = File.expand_path 'tmp/sockets/unicorn.sock', $app_dir
$pid = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$stdout_log = File.expand_path 'log/unicorn.log', $app_dir
$stderr_log = File.expand_path 'log/unicorn_error.log', $app_dir

# 上記で設定したものが適応されるよう定義
worker_processes $worker
working_directory $app_dir
stdout_path $stdout_log
stderr_path $stderr_log
timeout $timeout
listen $listen
pid $pid

# ホットデプロイをするかしないかを設定
preload_app true

# fork前に行うことを定義
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill 'QUIT', File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# fork後に行うことを定義
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
