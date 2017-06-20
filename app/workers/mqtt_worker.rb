class MqttWorker
  include Sidekiq::Worker

  def perform(method, params)
    send(method, params)
  end

  def parse_message(params)
    msg = JSON.parse(params['message'])
    Device.find(params['topic']).ping!(msg['gpio'])
  end

  def check_offline_devices(_params)
    Device.where(status: :online).where('pinged_at < ?', 30.seconds.ago).each &:offline!
  end
end
