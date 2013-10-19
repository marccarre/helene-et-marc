FactoryGirl.define do
  factory :event do
    locale_entry "rsvp.event.civil_ceremony"
    date Date.new(2014, 6, 27)
    time Time.new(2014, 6, 27, 15, 0, 0).in_time_zone("Europe/Paris")
  end
end

  # { :locale_entry => "rsvp.event.religious_ceremony", :date => Date.new(2014, 6, 28), :time => Time.new(2014, 6, 28, 14, 0, 0).in_time_zone("Europe/Paris") },
  # { :locale_entry => "rsvp.event.reception", :date => Date.new(2014, 6, 28), :time => Time.new(2014, 6, 28, 17, 0, 0).in_time_zone("Europe/Paris") },
  # { :locale_entry => "rsvp.event.retour", :date => Date.new(2014, 6, 29), :time => Time.new(2014, 6, 29, 11, 0, 0).in_time_zone("Europe/Paris") }