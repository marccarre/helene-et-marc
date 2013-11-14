module Wedding
  class Booking < ActiveRecord::Base
    has_many :guests, inverse_of: :booking, dependent: :destroy
    has_one :address, inverse_of: :booking, dependent: :destroy
    has_and_belongs_to_many :events

    validates :guests, presence: true, :length => { :minimum => 1 }
    validates :address, presence: true
    validates :coming, inclusion: { in: [true, false] }
    
    accepts_nested_attributes_for :guests #, :reject_if -> { |a| a[:content].blank? }
    accepts_nested_attributes_for :address #, :reject_if -> { |a| a[:content].blank? }
    accepts_nested_attributes_for :events #, :reject_if -> { |a| a[:content].blank? }

    scope :not_coming, -> { where(coming: false) }
    scope :coming, -> { where(coming: true) }
    scope :coming_to, -> (event_id) { coming.includes(:events).where("bookings_events.event_id = #{event_id}") }

    after_save :send_rsvp_confirmation

    private
    def send_rsvp_confirmation
      Wedding::RsvpMailer.rsvp_confirmation(self).deliver
    end
  end
end
