require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "returns http success" do
		get :new
    expect(response).to have_http_status(:success)
  end

end
