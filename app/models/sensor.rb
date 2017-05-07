class Sensor < ApplicationRecord
  belongs_to :device, inverse_of: :sensors, touch: true
end
