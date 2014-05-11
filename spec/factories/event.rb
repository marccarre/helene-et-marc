# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do

    #association :booking


    factory :civil_ceremony do |event|
      locale_entry 'rsvp.event.civil_ceremony'
      beginning    DateTime.new(2014, 6, 27, 15, 00, 0)
      event.end    DateTime.new(2014, 6, 27, 16, 00, 0)
    end

    factory :religious_ceremony do |event|
      locale_entry 'rsvp.event.religious_ceremony'
      beginning    DateTime.new(2014, 6, 28, 14, 00, 0)
      event.end    DateTime.new(2014, 6, 28, 15, 30, 0)
    end

    factory :cocktail do |event|
      locale_entry 'rsvp.event.cocktail'
      beginning    DateTime.new(2014, 6, 28, 17, 30, 0)
      event.end    DateTime.new(2014, 6, 28, 19, 30, 0)
    end

    factory :dinner do |event|
      locale_entry 'rsvp.event.dinner'
      beginning    DateTime.new(2014, 6, 28, 20, 00, 0)
      event.end    DateTime.new(2014, 6, 29, 03, 00, 0)
    end

    factory :retour do |event|
      locale_entry 'rsvp.event.retour'
      beginning    DateTime.new(2014, 6, 29, 11, 00, 0)
      event.end    DateTime.new(2014, 6, 29, 15, 00, 0)
    end
  end
end
