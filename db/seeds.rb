# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
exit(0) if Rails.env.test?

user = FactoryBot.create(:user)
FactoryBot.create(:telegram_channel, identifier: (Rails.env.production? ? '429212655': '429212655'), user: user) # same id for both environments. interesting...

facility = FactoryBot.create(:facility)
device = FactoryBot.create(:device, facility: facility)
sensor1 = FactoryBot.create(:sensor, device: device, gpio_listen: 16, gpio_pull: 0, gpio_ok: 16)
sensor2 = FactoryBot.create(:sensor, device: device, gpio_listen: 32, gpio_pull: 0, gpio_ok: 32)

if Rails.env.development?
  [sensor1, sensor2].each do |sensor|
    FactoryBot.create_list(:event, 5, target: sensor, facility: facility)
  end
end

FactoryBot.create(:user, admin: true, email: 'admin@example.com')
FactoryBot.create_list(:product, 3)
