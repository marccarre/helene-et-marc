module Wedding
  class PassengersMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    CC = ['carre.marc+wedding@gmail.com'] #, 'queguiner.helene+wedding@gmail.com']
    private_constant :FROM, :CC

    default from: FROM
    default cc: CC

    def passenger_confirmation(passenger_id)
      @passenger = Passenger.includes(:car).find(passenger_id)
      to = @passenger.email.presence || CC
      mail to: to, subject: t('passengers_mailer.subject')
    end
  end
end
