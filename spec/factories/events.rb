# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    start_at "2013-02-12 01:39:29"
    end_at "2013-02-12 01:39:29"
    event_type "training"
  end
end
