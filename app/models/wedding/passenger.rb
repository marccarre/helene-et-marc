module Wedding
  class Passenger < ActiveRecord::Base
    belongs_to :car
    
    CATEGORY = {
      driver: 1,
      passenger: 2
    }

    validates :car, presence: true
    validates :first_name, presence: true
    validates :family_name, presence: true
    validates :email, allow_blank: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "should be a valid email address" }
    validates :phone, presence: true
    validates :category, presence: true, inclusion: { in: CATEGORY.values }

    def is_driver? 
      category == CATEGORY[:driver]
    end

    def is_passenger? 
      category == CATEGORY[:passenger]
    end

    def to_s
      return to_json.to_s
    end
  end
end
