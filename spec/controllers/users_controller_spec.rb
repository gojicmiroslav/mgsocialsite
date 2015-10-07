require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do

  describe "GET #new_user_registration_path" do
    it "returns http success" do
    	@request.env["devise.mapping"] = Devise.mappings[:user]
			get :new
      expect(response).to have_http_status(:success)
    end
  end

end
