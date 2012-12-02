# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@example.com"
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
