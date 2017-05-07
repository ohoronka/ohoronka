# create_table :devices do |t|
#   t.timestamps
#
#   t.string :name
#   t.integer :gpio_listen, null: false, default: 0
#   t.integer :gpio_pull, null: false, default: 0
#   t.integer :gpio_ok, null: false, default: 0
# end

class Device < ApplicationRecord
end
