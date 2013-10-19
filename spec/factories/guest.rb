FactoryGirl.define do

  factory :guest do
    #sequence(:first_name) { |i| "John#{i}" }
    #sequence(:family_name) { |i| "Smith#{i}" }
    first_name Faker::Name.first_name
    family_name Faker::Name.last_name
    birth_date Date.parse('31-12-1980')
    children_menu false

    association :booking
  end
end