# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    phone       Faker::PhoneNumber.phone_number
    comments    'Allergies to sesame.'

    trait :coming do
      coming    true

      after(:build) do |booking|
        booking.events << FactoryGirl.build(:religious_ceremony)
        booking.events << FactoryGirl.build(:cocktail)
        booking.events << FactoryGirl.build(:dinner)
      end
    end

    trait :not_coming do
      coming    false
    end

    trait :with_email do
      email     Faker::Internet.email
    end

    trait :with_comments_longer_than_255_chars do
      comments  'This is a great website which allows me to write overly long comments, in which I tell you everything about my life, how I think I will come to this wedding, all the ingredients I am allergic to, what the kids like and dislike in terms of food, and the fact we would be interested in the nanny service.'
    end

    after(:build) do |booking|
      booking.guests << FactoryGirl.build(:guest, :adult, booking: booking)
    end
  end
end
