require 'rails_helper'

RSpec.feature "User index" do

	describe "with pagination" do
		fixtures :users

		let(:user){ FactoryGirl.create(:user) }
		let(:admin){ FactoryGirl.create(:admin) }

		scenario "index as non-admin including pagination" do
			login_as(user, :scope => :user)
			visit root_path
			expect(page).to have_link("Users", :href => users_path)
			click_on("Users")
			expect(page).to have_css("h1", text: "All Users")
			expect(page).to have_css("div.pagination")
			#first(:link, "2").click			
		end

		scenario "index as an admin including pagination and delete links" do
			login_as(admin, :scope => :user)
			visit users_path
			expect(page).to have_css("h1", text: "All Users")
			expect(page).to have_css("div.pagination")
			expect(page).to have_link("delete")
			expect { first(:link, "delete").click }.to change(User, :count).by(-1)
			expect(page).to have_css("div.alert", text: "User deleted")
		end
	end

end
