# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :car do
    from "MyString"
    to "MyString"
    leaving_time "2013-11-17 00:24:38"
    available_seats 1
    driver nil
    car_poolers nil
  end
end
