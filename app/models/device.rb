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

  private

  def update_gpio
    sensors.reload
    GPIO.each do |gpio|
      self.send("#{gpio}=".to_sym, sensors.map(&gpio).inject(&:|))
    end
  end
end
