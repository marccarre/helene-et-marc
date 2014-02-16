# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :car do
    from            Faker::Address.city
    to              Faker::Address.city
    departure_time  DateTime.now  
    available_seats (1..20).to_a.sample
    category        Wedding::Car::CATEGORY[:share]


    after(:build) do |car|
      car.driver = FactoryGirl.build(:driver, car: car) if !car.driver.present?
      car.passengers = [] if !car.passengers.present?
    end


    trait :requested do
      category      Wedding::Car::CATEGORY[:request]
    end

    trait :without_email do
      after(:build) do |car|
        car.driver = FactoryGirl.build(:driver, :without_email, car: car)
      end
    end 
  end
end
