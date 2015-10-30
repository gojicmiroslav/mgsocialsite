require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do

	describe "valid user" do
		let(:micropost){ FactoryGirl.create(:micropost) }
		let(:microposts_count) { Micropost.count}
		let(:user){ FactoryGirl.create(:user) }

		it "should redirect create when not logged in" do
			post :create, micropost: { content: "Lorem Ipsum"}
			expect(Micropost.count).to eq(microposts_count)
			expect(response).to redirect_to new_user_session_path
		end

		it "should redirect destroy when not logged in" do
			delete :destroy, id: micropost
			expect(Micropost.count).to eq(microposts_count)
			expect(response).to redirect_to new_user_session_path
		end
	end

	describe "wrong user" do
		fixtures :users
		fixtures :microposts

		let(:microposts_count) { Micropost.count}
		let(:user){ users(:miroslav) }
		let(:ants){ microposts(:ants) }

		it "should redirect destroy for wrong micropost" do
			sign_in user
			delete :destroy, id: ants 
			expect(Micropost.count).to eq(microposts_count)
		end
	end

end
