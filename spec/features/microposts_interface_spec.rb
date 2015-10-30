require 'rails_helper'

RSpec.feature "Micropost interface", :device do
	#fixtures :microposts

	let(:user){ FactoryGirl.create(:user_with_posts) }
	let(:microposts){ Micropost.count }
	let(:other_user){ FactoryGirl.create(:other_user) }

	scenario "micropost interface" do
		login_as(user, :scope => :user)
		visit root_url
		expect(page).to have_css("div.pagination")
		
		# Invalid submission
		fill_in 'micropost_content', with: ""
		click_on "Post"
		expect(page).to have_content("Content can't be blank")
		expect(page).to have_css('div#error_explanation')
		expect(Micropost.count).to eq(microposts)

		# Valid submission
		content = "This is valid content"
		fill_in 'micropost_content', with: content
		expect do
      click_on "Post"
    end.to change(Micropost, :count).by(1)
    expect(page).not_to have_content("Content can't be blank")
		expect(page).not_to have_css('div#error_explanation')

		# Delete a post
		expect(page).to have_link("delete")
		expect do
			first(:link, "delete").click
		end.to change(Micropost, :count).by(-1)	

		# Visit a different profile - delete links should disapear
		visit user_path(other_user)
		expect(page).not_to have_link("delete")
	end
	
end