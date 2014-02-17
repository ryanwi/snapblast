require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders the landing layout" do
      get :index
      response.should render_template("layouts/landing")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
    get :about
      response.should be_success
    end

    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end

    it "renders the application layout" do
      get :about
      response.should render_template("layouts/application")
    end
  end

end
