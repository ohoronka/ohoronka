class DeviceDecorator < ApplicationDecorator
  delegate_all

  def wifi_password
    '%08d' % object.options['wifi_password']
  end

  def wifi_ap
    "OHORONKA_#{object.number}"
  end
end
