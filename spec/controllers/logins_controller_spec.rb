require 'spec_helper'

describe LoginsController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "when no credentials, re-renders the new template" do
      post :create
      expect(response).to render_template("new")
    end

    it "when empty credentials, re-renders the new template" do
      post :create, :user => '', :password => ''
      expect(response).to render_template("new")
    end

    it "when bad credentials, re-renders the new template" do
      post :create, :user => 'test', :password => 'test'
      expect(response).to render_template("new")
    end
  end

end
