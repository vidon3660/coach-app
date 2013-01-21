# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    player
    
    email
    password "password"
    status "active"
    coach false

    factory :coach do
      coach true
    end
  end
end
