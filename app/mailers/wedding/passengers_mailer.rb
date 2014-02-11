module Wedding
  class PassengersMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    CC = ['carre.marc@gmail.com', 'queguiner.helene@gmail.com']
    private_constant :FROM, :CC

    default from: FROM
    default cc: CC

    def passenger_confirmation(passenger)
      @passenger = passenger
      to = @passenger.email || CC
      mail to: to, subject: t('passengers_mailer.subject')
    end
  end
end
