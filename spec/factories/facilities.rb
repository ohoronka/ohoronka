FactoryGirl.define do
  factory :facility do
    sequence(:name) {|n| "facility ##{n}"}

    before(:create) do |facility|
      facility.users << (User.take || create(:user))
    end
  end
end
