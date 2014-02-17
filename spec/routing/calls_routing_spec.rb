require "spec_helper"

describe CallsController do
  describe "routing" do

    it "does not expose a list of calls" do
      expect(:get => "/calls").not_to be_routable
    end

    it "does not expose a call" do
      expect(:get => "/calls/1").not_to be_routable
    end

    it "routes to #new" do
      get("/calls/new").should route_to("calls#new")
    end

    it "routes to #create" do
      post("/calls").should route_to("calls#create")
    end

  end
end
