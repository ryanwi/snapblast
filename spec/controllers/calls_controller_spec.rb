require 'spec_helper'

describe CallsController do

  describe "GET 'new'" do
    it "redirect to login" do
      get :new
      expect(response.status).to eq(302)
    end
  end

  describe "POST 'create'" do
    it "redirect to login" do
      post :create
      expect(response.status).to eq(302)
    end
  end

end
