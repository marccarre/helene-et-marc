require "spec_helper"
require "wedding/rsvp_mailer"
require "wedding/booking"
require "wedding/address"
include Wedding

describe RsvpMailer do 
  subject(:mail) { RsvpMailer.rsvp_confirmation(booking) }
  # let(:booking) { Booking.new(address: address) }
  # let(:address) { Address.new }
  let(:booking) { double(:booking, address: address, guests: nil, events: nil) }
  let(:address) { double(:address, email: nil) }
  let(:text) { get_part(mail, /plain/) }
  let(:html) { get_part(mail, /html/) }


  its(:from) { should include("les.carreguiners@gmail.com") }
  its(:cc) { should include("carre.marc@gmail.com", "queguiner.helene@gmail.com") }
  
  it { should be_a_multipart_email }
  context "html" do 
    its(:body) { html.should include("<body>") }
  end
  context "text" do
    its(:body) { text.should include("========") }
  end

  context "when locale in French (fr)" do
    before { I18n.locale = :fr }
    its(:subject) { should == "Hélène & Marc - Confirmation de présence" }
  end

  context "when locale in English (en)" do
    before { I18n.locale = :en }
    its(:subject) { should == "Hélène & Marc - Wedding confirmation" }
  end

  context "when booking does not have an email address" do
    its(:to) { should include("les.carreguiners@gmail.com", "carre.marc@gmail.com", "queguiner.helene@gmail.com") }
  end

  context "when booking for John Smith has an email address" do
    # let(:address) { Address.new(email: email) }
    let(:address) { double(:address, email: email) }
    let(:email) { "john.smith@hotmail.com" }

    its(:to) { should include(email) }
  end
end