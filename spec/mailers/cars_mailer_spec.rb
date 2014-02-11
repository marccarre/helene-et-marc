require "spec_helper"

describe CarsMailer do
  describe "car_confirmation" do
    let(:mail) { CarsMailer.car_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Car confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
