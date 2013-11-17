module Wedding
  class Passenger < ActiveRecord::Base
    belongs_to :car
    
    validates :car, presence: true
    validates :first_name, presence: true
    validates :family_name, presence: true
    validates :email, allow_blank: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "should be a valid email address" }
    validates :phone, presence: true
  end
end
