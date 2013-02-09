# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    password "password"
    status "active"
    coach false

    birth "2013-01-04"
    country "MyString"
    city "London"
    first_name "John"
    last_name "Kowalsky"
    phone "MyString"

    factory :coach do
      coach true
    end
  end
end
