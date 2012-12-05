# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    password "password"
    status "active"
    roles ["user"]
    first_name "John"
    last_name "Kowalsky"
    city "London"

    factory :admin do
      roles ["admin"]
    end

    factory :coach do
      roles ["coach"]
    end
  end
end
