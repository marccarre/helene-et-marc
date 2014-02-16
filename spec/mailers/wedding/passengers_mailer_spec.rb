require 'spec_helper'
require 'wedding/car'
require 'wedding/passenger'
require 'wedding/passengers_mailer'
include Wedding

describe PassengersMailer do
  describe 'passenger_confirmation' do

    context 'without any email provided' do
      let(:passenger) { FactoryGirl.create(:driver, :without_email) }
      subject(:mail)  { create_and_send_email(passenger) }

      its(:to) { should eq(mail.cc) } 
    end


    context 'with email provided' do      
      let(:passenger) { FactoryGirl.create(:driver) }
      subject(:mail)  { create_and_send_email(passenger) }

      its(:to) { should_not eq(mail.cc) } 
      its(:to) { should eq([passenger.email]) } 
    end


    context 'regardless of whether an email is provided or not' do
      let(:passenger) { FactoryGirl.create(:driver) }
      subject(:mail)  { create_and_send_email(passenger) }
      let(:plain)    { get_part(mail, /plain/) }
      let(:html)     { get_part(mail, /html/) }

      its(:from) { should eq(['les.carreguiners@gmail.com']) }
      its(:cc)   { should eq(['carre.marc+wedding@gmail.com']) } 
      it         { should be_a_multipart_email }


      context 'with French locale' do
        initial_locale = I18n.locale
        before(:each) { I18n.locale = :fr }
        after(:each)  { I18n.locale = initial_locale }

        its(:subject) { should eq('Hélène & Marc - Passager enregistré avec succès !') }

        it 'renders the plain body in French' do
          'Hélène & Marc - Passager enregistré avec succès !'.tokenize.each { |token| plain.should match(token) }
          '(Ceci est un email automatique que vous recevez suite à votre enregistrement en tant que passager d\'une voiture, dans la rubrique co-voiturage de www.helene-et-marc.fr)'.tokenize.each { |token| plain.should match(token) }
          'Détails du trajet'.tokenize.each { |token| plain.should match(token) }
          'Se désinscrire ?'.tokenize.each { |token| plain.should match(token) }
          'Pour vous supprimer de la liste des passagers, veuillez cliquer sur le lien suivant :'.tokenize.each { |token| plain.should match(token) }
          'Me désinscrire !'.tokenize.each { |token| plain.should match(token) }
        end

        it 'renders the HTML body in French' do
          'Hélène & Marc - Passager enregistré avec succès !'.tokenize.each { |token| html.should match(token) }
          '(Ceci est un email automatique que vous recevez suite à votre enregistrement en tant que passager d\'une voiture, dans la rubrique co-voiturage de www.helene-et-marc.fr)'.tokenize.each { |token| html.should match(token) }
          'Détails du trajet'.tokenize.each { |token| html.should match(token) }
          'Se désinscrire ?'.tokenize.each { |token| html.should match(token) }
          'Pour vous supprimer de la liste des passagers, veuillez cliquer sur le lien suivant :'.tokenize.each { |token| html.should match(token) }
          'Me désinscrire !'.tokenize.each { |token| html.should match(token) }
        end
      end


      context 'with English locale' do
        initial_locale = I18n.locale
        before(:each) { I18n.locale = :en }
        after(:each)  { I18n.locale = initial_locale }

        its(:subject) { should eq('Hélène & Marc - Successfully registered as passenger!') }

        it 'renders the plain body in English' do
          'Hélène & Marc - Successfully registered as passenger!'.tokenize.each { |token| plain.should match(token) }
          '(This an automated email that you are receiving following your registration as a passenger of a car on www.helene-et-marc.fr)'.tokenize.each { |token| plain.should match(token) }
          'Journey details'.tokenize.each { |token| plain.should match(token) }
          'Want to unregister ?'.tokenize.each { |token| plain.should match(token) }
          'To remove yourself from the list of passengers, please click on the following link:'.tokenize.each { |token| plain.should match(token) }
          'Unregister!'.tokenize.each { |token| plain.should match(token) }
        end

        it 'renders the HTML body in English' do
          'Hélène & Marc - Successfully registered as passenger!'.tokenize.each { |token| html.should match(token) }
          '(This an automated email that you are receiving following your registration as a passenger of a car on www.helene-et-marc.fr)'.tokenize.each { |token| html.should match(token) }
          'Journey details'.tokenize.each { |token| html.should match(token) }
          'Want to unregister ?'.tokenize.each { |token| html.should match(token) }
          'To remove yourself from the list of passengers, please click on the following link:'.tokenize.each { |token| html.should match(token) }
          'Unregister!'.tokenize.each { |token| html.should match(token) }
        end
      end
    end
  end


  def create_and_send_email(passenger)
    create_mail(passenger)
    send_mail
    ActionMailer::Base.deliveries.shift # Pop first email and ignore it, since it corresponds to the one sent following the creation of the car associated to the passenger.
    ActionMailer::Base.deliveries.first
  end

  def create_mail(passenger) # Create mail and put it on the Sidekiq queue:
    expect { 
      PassengersMailer.delay.passenger_confirmation(passenger)
    }.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
  end

  def send_mail # Execute all jobs in the queue:
    Sidekiq::Extensions::DelayedMailer.drain
  end
end
