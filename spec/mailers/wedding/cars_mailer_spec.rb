require 'spec_helper'
require 'wedding/car'
require 'wedding/passenger'
require 'wedding/cars_mailer'
include Wedding

describe CarsMailer, sidekiq: :acceptance do
  describe 'car_confirmation' do

    context 'without any email provided' do
      let(:car)      { FactoryGirl.create(:car, :without_email) }
      subject(:mail) { create_and_send_email(car) }

      its(:to) { should eq(mail.cc) } 
    end


    context 'with email provided' do      
      let(:car)      { FactoryGirl.create(:car) }
      subject(:mail) { create_and_send_email(car) }

      its(:to) { should_not eq(mail.cc) } 
      its(:to) { should eq([car.driver.email]) } 
    end


    context 'regardless of whether an email is provided or not' do
      let(:car)      { FactoryGirl.create(:car) }
      subject(:mail) { create_and_send_email(car) }
      let(:plain)    { get_part(mail, /plain/) }
      let(:html)     { get_part(mail, /html/) }

      its(:from) { should eq(['les.carreguiners@gmail.com']) }
      its(:cc)   { should eq(['carre.marc+wedding@gmail.com', 'queguiner.helene+wedding@gmail.com']) } 
      it         { should be_a_multipart_email }


      context 'with French locale' do
        initial_locale = I18n.locale
        before(:each) { I18n.locale = :fr }
        after(:each)  { I18n.locale = initial_locale }

        its(:subject) { should eq('Hélène & Marc - Co-voiturage ajouté avec succès !') }

        it 'renders the plain body in French' do
          'Hélène & Marc - Co-voiturage ajouté avec succès !'.tokenize.each { |token| plain.should match(token) }
          '(Ceci est un email automatique que vous recevez suite à la recherche ou l\'ajout d\'une voiture dans la rubrique co-voiturage de www.helene-et-marc.fr)'.tokenize.each { |token| plain.should match(token) }
          'Détails du trajet'.tokenize.each { |token| plain.should match(token) }
          'Se désinscrire ?'.tokenize.each { |token| plain.should match(token) }
          'Pour enlever ma recherche ou ma voiture de la rubrique co-voiturage, veuillez cliquer sur le lien suivant :'.tokenize.each { |token| plain.should match(token) }
          'Me désinscrire !'.tokenize.each { |token| plain.should match(token) }
        end

        it 'renders the HTML body in French' do
          'Hélène & Marc - Co-voiturage ajouté avec succès !'.tokenize.each { |token| html.should match(token) }
          '(Ceci est un email automatique que vous recevez suite à la recherche ou l\'ajout d\'une voiture dans la rubrique co-voiturage de www.helene-et-marc.fr)'.tokenize.each { |token| html.should match(token) }
          'Détails du trajet'.tokenize.each { |token| html.should match(token) }
          'Se désinscrire ?'.tokenize.each { |token| html.should match(token) }
          'Pour enlever ma recherche ou ma voiture de la rubrique co-voiturage, veuillez cliquer sur le lien suivant :'.tokenize.each { |token| html.should match(token) }
          'Me désinscrire !'.tokenize.each { |token| html.should match(token) }
        end
      end


      context 'with English locale' do
        initial_locale = I18n.locale
        before(:each) { I18n.locale = :en }
        after(:each)  { I18n.locale = initial_locale }

        its(:subject) { should eq('Hélène & Marc - Successfully registered carpooling journey!') }

        it 'renders the plain body in English' do
          'Hélène & Marc - Successfully registered carpooling journey!'.tokenize.each { |token| plain.should match(token) }
          '(This an automated email that you are receiving following the request or sharing of a car on www.helene-et-marc.fr)'.tokenize.each { |token| plain.should match(token) }
          'Journey details'.tokenize.each { |token| plain.should match(token) }
          'Want to unregister ?'.tokenize.each { |token| plain.should match(token) }
          'To remove your request or car from the carpooling section, please click on the following link:'.tokenize.each { |token| plain.should match(token) }
          'Unregister!'.tokenize.each { |token| plain.should match(token) }
        end

        it 'renders the HTML body in English' do
          'Hélène & Marc - Successfully registered carpooling journey!'.tokenize.each { |token| html.should match(token) }
          '(This an automated email that you are receiving following the request or sharing of a car on www.helene-et-marc.fr)'.tokenize.each { |token| html.should match(token) }
          'Journey details'.tokenize.each { |token| html.should match(token) }
          'Want to unregister ?'.tokenize.each { |token| html.should match(token) }
          'To remove your request or car from the carpooling section, please click on the following link:'.tokenize.each { |token| html.should match(token) }
          'Unregister!'.tokenize.each { |token| html.should match(token) }
        end
      end
    end
  end


  def create_and_send_email(car)
    create_mail(car)
    send_mail
    ActionMailer::Base.deliveries.first
  end

  def create_mail(car) # Create mail and put it on the Sidekiq queue:
    expect { 
      CarsMailer.delay.car_confirmation(car)
    }.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
  end

  def send_mail # Execute all jobs in the queue:
    Sidekiq::Extensions::DelayedMailer.drain
  end
end
