# require 'sidekiq/cli'

Sidekiq.configure_server do |config|
  config.redis = Ohoronka::Application::REDIS_CONFIG[:sidekiq]
end

Sidekiq.configure_client do |config|
  config.redis = Ohoronka::Application::REDIS_CONFIG[:sidekiq]
end

# Thread.new do
#   begin
#     cli = Sidekiq::CLI.instance
#     cli.parse
#     cli.run
#   rescue => e
#     raise e if $DEBUG
#     STDERR.puts e.message
#     STDERR.puts e.backtrace.join("\n")
#     exit 1
#   end
# end
