require "spec_helper"

describe TeamsController do
  describe "routing" do

    it "routes to #index" do
      get("/teams").should route_to("teams#index")
    end

    it "does not expose a team" do
      expect(:get => "/teams/1").not_to be_routable
    end

    it "does not expose a team form" do
      expect(:get => "/teams/new").not_to be_routable
    end

    it "does not create a team" do
      expect(:post => "/teams").not_to be_routable
    end

  end
end
