module Wedding
  class Car < ActiveRecord::Base
    belongs_to :driver
    has_many :car_poolers
  end
end