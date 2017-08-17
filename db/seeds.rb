# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
exit(0) if Rails.env.test?

user = FactoryGirl.create(:user)
FactoryGirl.create(:telegram_channel, identifier: (Rails.env.production? ? '429212655': '429212655'), user: user) # same id for both environments. interesting...

facility = FactoryGirl.create(:facility, user_ids: [user.id])
device = FactoryGirl.create(:device, facility: facility)
sensor1 = FactoryGirl.create(:sensor, device: device, gpio_listen: 16, gpio_pull: 0, gpio_ok: 16)
sensor2 = FactoryGirl.create(:sensor, device: device, gpio_listen: 32, gpio_pull: 0, gpio_ok: 32)

if Rails.env.development?
  [sensor1, sensor2].each do |sensor|
    FactoryGirl.create_list(:event, 5, target: sensor, facility: facility)
  end
end

FactoryGirl.create(:user, admin: true, email: 'admin@example.com')
