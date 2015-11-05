require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
	fixtures :users
	#fixtures :relationships

	let(:user){ users(:miroslav) }
	let(:other_user){ users(:pera) }

	xscenario "following page" do
		signin(user.email, "password")
		click_on "following"
		expect(user.following.count).not_to eq(0)
		expect(page).to have_content(user.following.count.to_s)

		user.following.each do |u|
			expect(page).to have_link(u.name, :href => user_path(u))
		end
	end

	xscenario "followers page" do
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
			find("input[name=commit]").click
		end.to change(Relationship, :count).by(1)
		expect(page).to have_css("input[value=Unfollow]")
		# Unfollow
		expect do
			find("input[name=commit]").click
		end.to change(Relationship, :count).by(-1)
	end

	private

  def signin(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end

end