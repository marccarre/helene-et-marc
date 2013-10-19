require "spec_helper"

describe "routes for wedding" do
  it "routes / to /wedding" do
    expect(get("/wedding")).to route_to("wedding/wedding#home")
  end

  #expect(:delete => "/accounts/37").not_to be_routable
end