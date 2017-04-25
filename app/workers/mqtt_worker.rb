class MqttWorker
  include Sidekiq::Worker

  def perform(method, *args)
    send(method, *args)
  end

  def parse_message(topic:, message:)
    # TODO process message
  end
end
