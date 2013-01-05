# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
  	
    address "MyString"
    birth "2013-01-04"
    country "MyString"
    city "London"  
    first_name "John"
    last_name "Kowalsky"
    phone "MyString"

  end
end
