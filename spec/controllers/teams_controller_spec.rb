require 'spec_helper'

describe TeamsController do

  describe "GET 'index'" do
    it "redirect to login" do
      get :index
      expect(response.status).to eq(302)
    end
  end

end
