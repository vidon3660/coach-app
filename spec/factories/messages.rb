FactoryGirl.define do
  sequence :subject do |n|
    "Message Subject #{n}"
  end

  factory :message do
    subject
    body "Body content"
  end
end
