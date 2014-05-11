# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest do
    first_name  Faker::Name.first_name
    family_name Faker::Name.last_name
    
    association :booking


    trait :adult do
      category  Wedding::Guest::CATEGORY[:adult]
      menu      Wedding::Guest::MENU[:adult]
    end

    trait :child do
      category  Wedding::Guest::CATEGORY[:child]
    end

    trait :with_adult_menu do
      menu      Wedding::Guest::MENU[:adult]
    end

    trait :with_child_menu do
      menu      Wedding::Guest::MENU[:child]
    end

    trait :with_no_meal do
      menu      Wedding::Guest::MENU[:nothing]
    end
  end
end
