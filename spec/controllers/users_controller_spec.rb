require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user){ FactoryGirl.create(:user) }
  let(:other_user){ FactoryGirl.create(:other_user) }
  let(:users){ User.all }

  it "should redirect index when not logged in" do
    get :index
    expect(response).to redirect_to new_user_session_path
  end

  #it "should redirect profile when logged in as wrong user" do
  	#sign_in other_user
  	#get :show, id: user
  	#expect(response).to redirect_to root_url
  #end

  it "should redirect destroy when not logged in" do
    delete :destroy, id: user
    expect(users).to eq(User.all)
    expect(response).to redirect_to new_user_session_path
  end

  it "should redirect destroy when logged in as non-admin" do
    sign_in other_user
    delete :destroy, id: user
    expect(users).to eq(User.all)
    expect(response).to redirect_to root_url
  end

end
