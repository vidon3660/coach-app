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
    roles ["user"]

    factory :admin do
      roles ["admin"]
    end

    factory :coach do
      roles ["coach"]
    end
  end
end
