module Wedding
  class CarsMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    CC = ['carre.marc@gmail.com', 'queguiner.helene@gmail.com']
    private_constant :FROM, :CC

    default from: FROM
    default cc: CC

    def car_confirmation(car)
      @car = car
      to = @car.driver.email || CC
      mail to: CC, subject: t('cars_mailer.subject')
    end
  end
end
