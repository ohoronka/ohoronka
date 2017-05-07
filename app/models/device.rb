# create_table :devices do |t|
#   t.timestamps
#
#   t.string :name
#   t.integer :gpio_listen, null: false, default: 0
#   t.integer :gpio_pull, null: false, default: 0
#   t.integer :gpio_ok, null: false, default: 0
# end

class Device < ApplicationRecord
  GPIO = [:gpio_listen, :gpio_pull, :gpio_ok]
  has_many :sensors, inverse_of: :device, dependent: :destroy

  after_touch :update_gpio

  def ping(gpio)
    # update(pinged_at: Time.current)
    # TODO implement alarm
    raise 'Alarm' if ((gpio & gpio_listen) ^ gpio_ok) != 0
  end

  private

  def update_gpio
    sensors.reload
    GPIO.each do |gpio|
      self.send("#{gpio}=".to_sym, sensors.map(&gpio).inject(&:|))
    end
  end
end
