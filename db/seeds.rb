# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Wedding::Parameters.find_or_initialize_by(name: "time_zone").tap do |t|
  t.value = "Europe/Paris"
  t.save!
end
time_zone = Wedding::Parameters.find_by(name: "time_zone").value

# ---------------------------------------------------- Create or update events:
events = [
  { locale_entry: "rsvp.event.civil_ceremony",     beginning: DateTime.new(2014, 6, 27, 15, 00, 0), end: DateTime.new(2014, 6, 27, 16, 00, 0) },
  { locale_entry: "rsvp.event.religious_ceremony", beginning: DateTime.new(2014, 6, 28, 14, 00, 0), end: DateTime.new(2014, 6, 28, 15, 30, 0) },
  { locale_entry: "rsvp.event.cocktail",           beginning: DateTime.new(2014, 6, 28, 17, 30, 0), end: DateTime.new(2014, 6, 28, 19, 30, 0) },
  { locale_entry: "rsvp.event.dinner",             beginning: DateTime.new(2014, 6, 28, 20, 00, 0), end: DateTime.new(2014, 6, 29, 03, 00, 0) },
  { locale_entry: "rsvp.event.retour",             beginning: DateTime.new(2014, 6, 29, 11, 00, 0), end: DateTime.new(2014, 6, 29, 15, 00, 0) }
]

events.each do |event|
  locale_entry = event[:locale_entry]
  Wedding::Event.find_or_initialize_by(locale_entry: locale_entry).tap do |t|
    t.locale_entry = locale_entry
    t.beginning = event[:beginning]
    t.end = event[:end]
    t.save!
  end
end

# ------------------------------------------------ Create or update parameters:
wedding = Wedding::Event.find_by(locale_entry: "rsvp.event.religious_ceremony")
Wedding::Parameters.find_or_initialize_by(name: "wedding").tap do |t|
  t.value = wedding.id.to_s
  t.save!
end

# -----------------------------------------------------------------------------