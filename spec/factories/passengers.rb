# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :passenger do
    first_name  Faker::Name.first_name
    family_name Faker::Name.last_name
    email       Faker::Internet.email
    phone       Faker::PhoneNumber.phone_number
    category    Wedding::Passenger::CATEGORY[:passenger]

    association :car


    trait :without_email do
      email     ''
    end

    factory :driver do
      category  Wedding::Passenger::CATEGORY[:driver]
    end
  end
end
