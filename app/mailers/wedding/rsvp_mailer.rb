module Wedding
  class RsvpMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    TO = ['carre.marc+wedding@gmail.com', 'queguiner.helene+wedding@gmail.com']
    private_constant :FROM, :TO

    default from: FROM
    default to: TO

    def rsvp_confirmation(booking_id)
      @booking = Booking.includes(:guests).includes(:events).find(booking_id)
      mail to: TO, subject: t('rsvp_mailer.subject')
    end
  end
end
