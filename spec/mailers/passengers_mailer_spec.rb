require "spec_helper"

describe PassengersMailer do
  describe "passenger_confirmation" do
    let(:mail) { PassengersMailer.passenger_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Passenger confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
