# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_discipline do
    discipline
    is_coach true
  end
end
