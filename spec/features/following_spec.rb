require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
	fixtures :users
	fixtures :relationships

	let(:user){ users(:miroslav) }
	let(:other_user){ users(:pera) }

	scenario "following page" do
		signin(user.email, "password")
		click_on "following"
		expect(user.following.count).not_to eq(0)
		expect(page).to have_content(user.following.count.to_s)

		user.following.each do |u|
			expect(page).to have_link(u.name, :href => user_path(u))
		end
	end

	scenario "followers page" do
		signin(user.email, "password")
		click_on "followers"
		expect(user.followers.count).not_to eq(0)
		expect(page).to have_content(user.followers.count.to_s)

		user.followers.each do |u|
			expect(page).to have_link(u.name, :href => user_path(u))
		end
	end

	scenario "should follow and unfollow a user the standard way" do
		signin(user.email, "password")
		click_on "Users"
		expect(page).to have_content("All Users")
		first(:link, other_user.name).click
		
		# Follow
		expect do
			#find("button[value=Follow]").click
			click_button "Follow"
		end.to change(Relationship, :count).by(1)
		
		# Unfollow
		expect do
			#find("button[value=Unfollow]").click
			click_button "Unfollow"
		end.to change(Relationship, :count).by(-1)
	end

end