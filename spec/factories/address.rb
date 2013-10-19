FactoryGirl.define do

  factory :address do
    phone "+44 789 0123 456"
    address "42 Baker Street"
    city "London"
    country "United Kingdom"
    email "john.smith@hotmail.com"

    association :booking
  end
end