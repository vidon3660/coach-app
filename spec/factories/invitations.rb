# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    inviting { FactoryGirl.create :user }
    invited  { FactoryGirl.create :user }
    status   "expectant"
  end
end
