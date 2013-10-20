# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# ---------------------------------------------------- Create or update events:
events = [
  { :locale_entry => "rsvp.event.civil_ceremony", :date => Date.new(2014, 6, 27), :time => Time.new(2014, 6, 27, 15, 0, 0).in_time_zone("Europe/Paris") },
  { :locale_entry => "rsvp.event.religious_ceremony", :date => Date.new(2014, 6, 28), :time => Time.new(2014, 6, 28, 14, 0, 0).in_time_zone("Europe/Paris") },
  { :locale_entry => "rsvp.event.reception", :date => Date.new(2014, 6, 28), :time => Time.new(2014, 6, 28, 17, 0, 0).in_time_zone("Europe/Paris") },
  { :locale_entry => "rsvp.event.retour", :date => Date.new(2014, 6, 29), :time => Time.new(2014, 6, 29, 11, 0, 0).in_time_zone("Europe/Paris") }
]

events.each do |event|
  locale_entry = event[:locale_entry]
  Wedding::Event.find_or_initialize_by(locale_entry: locale_entry).tap do |t|
    t.locale_entry = locale_entry
    t.date = event[:date]
    t.time = event[:time]
    t.save!
  end
end

# ------------------------------------------------ Create or update parameters:
wedding = Wedding::Event.find_by(locale_entry: "rsvp.event.religious_ceremony")
Wedding::Parameters.find_or_initialize_by(name: "wedding").tap do |t|
  t.value = wedding.id
  t.save!
end

# -----------------------------------------------------------------------------