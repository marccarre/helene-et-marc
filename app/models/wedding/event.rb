module Wedding
  class Event < ActiveRecord::Base
    has_and_belongs_to_many :bookings
  end
end
