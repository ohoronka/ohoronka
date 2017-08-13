# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
sensors = FactoryGirl.create_list(:sensor, 4, device: FactoryGirl.create(:device))
sensors.each do |sensor|
  FactoryGirl.create_list(:event, 5, target: sensor, facility: Facility.take)
end
user = FactoryGirl.create(:user, account: Account.take)
FactoryGirl.create(:channel, identifier: '429212655', user: user)

FactoryGirl.create(:user, admin: true, email: 'admin@example.com')
