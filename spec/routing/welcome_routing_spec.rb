require "spec_helper"

describe WelcomeController do
  describe "routing" do

    it "routes to #index" do
      get("/").should route_to("welcome#index")
    end

    it "routes to #about" do
      get("/about").should route_to("welcome#about")
    end

  end
end
