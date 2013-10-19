FactoryGirl.define do

  factory :adult_guest do
    #sequence(:first_name) { |i| "Big John#{i}" }
    #sequence(:family_name) { |i| "Smith#{i}" }
    first_name "Big " + Faker::Name.first_name
    family_name Faker::Name.last_name

    association :booking
  end
end