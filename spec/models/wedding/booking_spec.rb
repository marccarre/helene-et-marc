require 'spec_helper'
require 'wedding/rsvp_mailer'
require 'wedding/booking'
require 'wedding/guest'
require 'wedding/event'
include Wedding

describe Booking do 
  subject(:booking) { FactoryGirl.build(:booking) }


  context 'public members' do
    it { should respond_to(:guests) }
    it { should respond_to(:events) }
    it { should respond_to(:coming) }
    it { should respond_to(:email) }
    it { should respond_to(:phone) }
  end

  context 'private members' do 
    it { should_not respond_to(:send_rsvp_confirmation) }
  end      

  context 'associations' do
    it { should have_many(:guests).class_name(Guest).dependent(:destroy) }
    it { should have_and_belong_to_many(:events).class_name(Event) }
  end

  context 'validations' do
    it { should validate_presence_of(:guests) }
    it { should validate_presence_of(:phone) }
    it { should_not validate_presence_of(:email) }
  end

  context 'coming' do
    subject(:booking) { FactoryGirl.build(:booking, :coming) }

    it { should be_valid }
    its(:phone) { should_not be_nil }  
    its(:email) { should     be_nil }
    its(:comments) { should  eq('Allergies to sesame.') }
    it { should have(1).guests }
    it { should have(3).events }

    context 'with an email address' do
      subject(:booking) { FactoryGirl.build(:booking, :coming, :with_email) }
      its(:email) { should_not be_nil }
    end

    context 'with comment longer than 255 characters' do
      subject(:booking) { FactoryGirl.build(:booking, :coming, :with_comments_longer_than_255_chars) }
      comments_longer_than_255_chars = 'This is a great website which allows me to write overly long comments, in which I tell you everything about my life, how I think I will come to this wedding, all the ingredients I am allergic to, what the kids like and dislike in terms of food, and the fact we would be interested in the nanny service.'

      its(:comments) { should eq(comments_longer_than_255_chars) }

      it 'can be saved successfully, with all of the comments' do
        # booking.save should_not raise_error(Exception)
        expect { booking.save }.to_not raise_error(Exception)

        # its(:errors) { should be_empty }
        # expect { booking.errors }.to be_empty
        assert booking.errors.empty?
        
        # its(:comments) { should eq(comments_longer_than_255_chars) }
        #expect { booking.comments }.to eq(comments_longer_than_255_chars)
        assert_equal comments_longer_than_255_chars, booking.comments
      end
    end
  end
end
