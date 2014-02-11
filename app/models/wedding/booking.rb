module Wedding
  class Booking < ActiveRecord::Base
    has_many :guests, inverse_of: :booking, dependent: :destroy
    has_and_belongs_to_many :events

    validates :guests, presence: true, length: { minimum: 1 }
    validates :coming, inclusion: { in: [true, false] }
    validates :email, allow_blank: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "should be a valid email address" }
    validates :phone, presence: true
    
    accepts_nested_attributes_for :guests
    accepts_nested_attributes_for :events

    scope :not_coming, -> { where(coming: false) }
    scope :coming, -> { where(coming: true) }
    scope :coming_to, -> (event_id) { coming.includes(:events).where("bookings_events.event_id = #{event_id}") }

    after_save :send_rsvp_confirmation

    private
      def send_rsvp_confirmation
        RsvpMailer.delay.rsvp_confirmation(self)
      end
  end
end
