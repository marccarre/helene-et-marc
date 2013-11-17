# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :passenger do
    first_name "MyString"
    family_name "MyString"
    email "MyString"
    phone "MyString"
  end
end
