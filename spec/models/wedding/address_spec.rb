require "spec_helper"
require "wedding/address"
require "wedding/adult_guest"
require "wedding/booking"
include Wedding

describe Address do 
  # let(:booking) { FactoryGirl.build(:booking) }
  # subject(:address) { FactoryGirl.build(:address, booking: booking) }
  subject(:address) { FactoryGirl.build(:address) }

  it { should belong_to(:booking).class_name(Booking) }
  
  it { should validate_presence_of(:booking) }
  it { should_not validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:postcode) }
  it { should validate_presence_of(:country) }

  it { should_not be_valid }

  context "with an email address" do
    its(:phone) { should == "+44 789 0123 456" }
    its(:email) { should == "john.smith@hotmail.com" }
  end

  context "without an email address" do
    subject(:address) { FactoryGirl.build(:address, email: nil) }
    its(:phone) { should == "+44 789 0123 456" }
    its(:email) { should be_nil }
  end
end