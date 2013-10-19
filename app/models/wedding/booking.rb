class Wedding::Booking < ActiveRecord::Base
  has_many :adults, class_name: "AdultGuest", inverse_of: :booking, dependent: :destroy
  has_many :children, class_name: "ChildGuest", inverse_of: :booking, dependent: :destroy
  has_one :address, inverse_of: :booking, dependent: :destroy
  has_and_belongs_to_many :events

  #validates :adults, presence: true #, :length => { :minimum => 1 }
  #validates :address, presence: true

  accepts_nested_attributes_for :adults #, :reject_if -> { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :children #, :reject_if -> { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :address #, :reject_if -> { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :events #, :reject_if -> { |a| a[:content].blank? }, :allow_destroy => true

  scope :not_coming, -> { where("bookings.id NOT IN (SELECT DISTINCT(bookings_events.booking_id) FROM bookings_events)") }
  scope :coming, -> { where("bookings.id IN (SELECT DISTINCT(bookings_events.booking_id) FROM bookings_events)") }
  scope :coming_to, -> (event_id) { coming.includes(:events).where("bookings_events.event_id = #{event_id}") }

  def guests
    Wedding::Guest.where(booking: self)
  end

  after_save :send_rsvp_confirmation

  private
  def send_rsvp_confirmation
    Wedding::RsvpMailer.rsvp_confirmation(self).deliver
  end
end