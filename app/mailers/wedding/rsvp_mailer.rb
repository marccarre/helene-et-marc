class Wedding::RsvpMailer < ActionMailer::Base
  FROM = ["les.carreguiners@gmail.com"]
  #CC = ["carre.marc@gmail.com", "queguiner.helene@gmail.com"]
  CC = ["carre.marc@gmail.com"]
  private_constant :FROM, :CC

  default from: FROM
  default cc: CC

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.rsvp_mailer.rsvp_submitted.subject
  #
  def rsvp_confirmation(booking)
    @booking = booking
    #to = @booking.address.email || (FROM + CC)
    to = "carre.marc@gmail.com"
    mail to: to, subject: t("rsvp_mailer.rsvp_submitted.subject")
  end
end
