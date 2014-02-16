module Wedding
  class CarsMailer < ActionMailer::Base
    FROM = ['les.carreguiners@gmail.com']
    CC = ['carre.marc+wedding@gmail.com', 'queguiner.helene+wedding@gmail.com']
    private_constant :FROM, :CC

    default from: FROM
    default cc: CC

    def car_confirmation(car_id)
      @car = Car.includes(:driver).find(car_id)
      to = @car.driver.email.presence || CC
      mail to: to, subject: t('cars_mailer.subject')  
    end
  end
end
