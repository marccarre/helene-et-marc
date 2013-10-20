class Wedding::Guest < ActiveRecord::Base
  belongs_to :booking
  
  validates :first_name, presence: true
  validates :family_name, presence: true

  scope :coming, -> { where("booking_id IN (SELECT DISTINCT(booking_id) FROM bookings_events)") }
  scope :not_coming, -> { where("booking_id NOT IN (SELECT DISTINCT(booking_id) FROM bookings_events)") }

  scope :adults, -> { where(birth_date: nil).where(child_menu: nil) }
  scope :children, -> { where("birth_date IS NOT NULL").where("child_menu IS NOT NULL") }

  scope :with_child_menu, -> { coming.where(child_menu: true) }
  scope :with_adult_menu, -> { coming.where("(child_menu = 'FALSE') OR (child_menu IS NULL)") }

  def is_adult?
    birth_date.nil? && child_menu.nil?
  end 

  def is_child?
    !is_adult?
  end
end
