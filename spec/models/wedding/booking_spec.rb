require "spec_helper"
require "wedding/rsvp_mailer"
require "wedding/booking"
require "wedding/guest"
require "wedding/address"
require "wedding/event"
include Wedding

describe Booking do 
  subject(:booking) { FactoryGirl.build(:booking) }

  context "associations" do
    it { should have_many(:adults).class_name(AdultGuest).dependent(:destroy) }
    it { should validate_presence_of(:adults) }
    
    it { should have_many(:children).class_name(ChildGuest).dependent(:destroy) }
    
    it { should have_one(:address).class_name(Address).dependent(:destroy) }
    it { should validate_presence_of(:address) }

    it { should have_and_belong_to_many(:events).class_name(Event) }
  end

  context "by default" do
    subject(:booking) { Booking.new }
    it { should respond_to(:adults) }
    it { should respond_to(:children) }
    it { should respond_to(:guests) }
    it { should respond_to(:address) }
    it { should respond_to(:events) }
    it { should have(0).adults }
    it { should have(0).children }
    it { should have(0).guests }
    its(:address) { should be_nil }
    it { should have(0).events }
    it { should_not be_valid }
    it { should_not respond_to(:send_rsvp_confirmation) }
  end

  context "with an adult guest" do
    subject(:booking) { 
      booking = FactoryGirl.build(:booking)
      booking.adults = [adult]
      return booking 
    }
    let(:adult) { AdultGuest.new }

    it { should have(1).adults }
    it { should have(0).children }
    it { should have(0).guests }
    it { should be_valid }

    context "after save" do
      let(:mail) { double(:mail, deliver: true) }

      it { 
        booking.save
        booking.should have(1).guests 
      }

      it "calls 'rsvp_confirmation' on the RsvpMailer" do
        RsvpMailer.should_receive(:rsvp_confirmation).with(booking).and_return(mail)
        booking.save
      end

      it "calls 'deliver' on the mail object" do
        RsvpMailer.stub(rsvp_confirmation: mail)
        mail.should_receive(:deliver).and_return(true)
        booking.save
      end
    end 
  end
end