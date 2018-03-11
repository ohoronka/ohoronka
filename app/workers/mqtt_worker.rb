class MqttWorker
  include Sidekiq::Worker

  def perform(method, params = nil)
    send(method, params)
  end

  def parse_message(params)
    split_topic = params['topic'].split('/')
    device_number = split_topic.first.to_i
    topic = split_topic[1]

    case topic
    when 'm'
      msg = JSON.parse(params['message'])
      device = Device.find_by(number: device_number) || raise(ActiveRecord::RecordNotFound, "device with number #{device_number} is not found")
      device.alarm_service.handle_device_message(msg)
    when 'rpc'
      Rails.logger.info("RPC message received: #{params.to_json}")
    else
      Rails.logger.error("Unknown message received: #{params.to_json}")
    end
  rescue JSON::ParserError => e
    # TODO notify developers
    Rails.logger.error(e.message)
    Rails.logger.error("ParseError: #{params.to_json}")
  end

  def check_offline_devices(_params)
    AlarmService.check_offline_devices
    MqttWorker.perform_in(30.seconds, :check_offline_devices, {}) unless Rails.env.test?
  end
end
