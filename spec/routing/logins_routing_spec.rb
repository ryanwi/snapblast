require "spec_helper"

describe LoginsController do
  describe "routing" do

    it "does not expose a list of logins" do
      expect(:get => "/logins").not_to be_routable
    end

    it "does not expose a login" do
      expect(:get => "/logins/1").not_to be_routable
    end

    it "routes to #new" do
      get("/login").should route_to("logins#new")
    end

    it "routes to #new" do
      get("/logins/new").should route_to("logins#new")
    end

    it "routes to #create" do
      post("/logins").should route_to("logins#create")
    end

    it "routes to #destroy" do
      delete("/logins").should route_to("logins#destroy")
    end

  end
end
