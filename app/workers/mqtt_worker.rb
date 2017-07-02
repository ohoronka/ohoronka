class MqttWorker
  include Sidekiq::Worker

  def perform(method, params = nil)
    send(method, params)
  end

  def parse_message(params)
    split_topic = params['topic'].split('/')
    device_id = split_topic.first.to_i
    topic = split_topic[1]

    case topic
    when 'm'
      msg = JSON.parse(params['message'])
      Device.find(params['topic'].split('/').first).ping!(msg['gpio'])
    when 'rpc'
      Rails.logger.info("RPC message received: #{params['topic']}:#{params['message']}")
    end
  rescue JSON::ParserError => e
    # TODO notify developers
    Rails.logger.error(e.message)
    Rails.logger.error("ParseError: #{params['topic']} # #{params['message']}")
  end

  def check_offline_devices(_params)
    Device.where(status: :online).where('pinged_at < ?', 30.seconds.ago).each &:offline!
    MqttWorker.perform_in(30.seconds, :check_offline_devices, {}) unless Rails.env.test?
  end
end
