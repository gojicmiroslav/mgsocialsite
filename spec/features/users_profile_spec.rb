require 'rails_helper'

RSpec.feature "User Profile", :device do

	let(:user){ FactoryGirl.create(:user_with_posts) }
	
	scenario "profile display" do
		signin(user.email, user.password)
		visit user_path(user)
		expect(page).to have_selector("title",
																		:text => full_title(user.name),
																		:visible => false)	
		expect(page).to have_css("h1", text: user.name)
		expect(page).to have_css("img.gravatar")
		expect(page).to have_content(user.microposts.count.to_s)
		expect(page).to have_css("div.pagination")
	end
end