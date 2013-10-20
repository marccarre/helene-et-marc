class Wedding::RsvpMailer < ActionMailer::Base
  FROM = ["les.carreguiners@gmail.com"]
  CC = ["carre.marc@gmail.com", "queguiner.helene@gmail.com"]
  private_constant :FROM, :CC

  default from: FROM
  default cc: CC

  def rsvp_confirmation(booking)
    @booking = booking
    to = @booking.address.email || (FROM + CC)
    mail to: to, subject: t("rsvp_mailer.rsvp_submitted.subject")
  end
end
