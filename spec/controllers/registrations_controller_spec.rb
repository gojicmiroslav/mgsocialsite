require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

	before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "returns http success" do
		get :new
    expect(response).to have_http_status(:success)
  end

  it "should redirect edit when not logged in" do
  	@user = FactoryGirl.create(:user)
  	get :edit
  	expect(response).not_to render_template("edit")
  	expect(flash).not_to be_nil
  	expect(controller).to set_flash[:alert]
  	expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
  	expect(response).to redirect_to('/users/sign_in')
  end

  it "should redirect update when not logged in" do
  	@user = FactoryGirl.create(:user)
  	patch :update, id: @user, user: { name: @user.name, email: @user.email }
  	expect(response).to redirect_to('/users/sign_in')
  end

end
