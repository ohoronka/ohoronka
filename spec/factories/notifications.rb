FactoryGirl.define do
  factory :notification do
    user nil
    target ""
    message "MyString"
    read false
  end
end
