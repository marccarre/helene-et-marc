class Wedding::Address < ActiveRecord::Base
  belongs_to :booking
  validates :booking, presence: true
  
  validates :email, allow_blank: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "should be a valid email address" }
  validates :phone, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postcode, presence: true
  validates :country, presence: true
end
