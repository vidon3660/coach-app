# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prohibition_user do
    prohibition
    user
  end
end
