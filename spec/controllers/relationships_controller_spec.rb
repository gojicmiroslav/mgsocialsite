require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

	let(:relationships_count) { Relationship.count}
  let(:user){ FactoryGirl.create(:user) }

  describe "redirect when not logged in " do
    fixtures :users
    fixtures :relationships

  	it "should redirect create when not logged in" do
      post :create
      expect(Relationship.count).to eq(relationships_count)
      expect(response).to redirect_to new_user_session_path
    end

    it "should redirect destroy when not logged in" do
      delete :destroy, id: relationships(:one)
      expect(Relationship.count).to eq(relationships_count)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "creating a relationship with ajax" do
    let(:other_user) { FactoryGirl.build(:miroslav) }
    let(:id){ '1' }

    before do 
      sign_in user 
      
      allow(other_user).to receive(:id).and_return(id)
      allow(User).to receive(:find) { other_user }
    end
    
    it "should increment the Relationship count followed" do
      expect do
        xhr :post, :create, relationship: { followed_id: id }
      end.to change(Relationship, :count).by(1)
    end

    it "should increment the Relationship count follower" do
      expect do
        xhr :post, :create, relationship: { follower_id: id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success followed" do
      xhr :post, :create, relationship: { followed_id: id }
      expect(response).to have_http_status(:success)
    end

    it "should respond with success follower" do
      xhr :post, :create, relationship: { follower_id: id }
      expect(response).to have_http_status(:success)
    end

    #NE RADI
    xit "should follow a user" do
      expect do
        xhr :post, :create, relationship: { followed_id: id }
      end.to change{ user.following.count }.by(1)
    end
  end

end
