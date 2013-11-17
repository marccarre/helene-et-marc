module Wedding
  class Passenger < ActiveRecord::Base
    belongs_to car:
  end
end
