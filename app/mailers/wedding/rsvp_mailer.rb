module Wedding
  class RsvpMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    TO = ['carre.marc@gmail.com', 'queguiner.helene@gmail.com']
    private_constant :FROM, :TO

    default from: FROM
    default to: TO

    def rsvp_confirmation(booking)
      @booking = booking
      mail to: TO, subject: t('rsvp_mailer.subject')
    end
  end
end
