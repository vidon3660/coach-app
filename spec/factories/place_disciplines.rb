# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place_discipline do
    description "MyText"
    discipline
    place
  end
end
