require 'rails_helper'

RSpec.feature "User Edit", :device do

	let(:user){ FactoryGirl.create(:user) }

	scenario "unsuccessful edit" do	
		login_as(user, :scope => :user)
		visit edit_user_registration_path(user)
		fill_in 'Email', :with => 'newemail@invalid'
		fill_in 'Current password', :with => user.password
		click_button 'Save changes'
		expect(page).to have_content("Email is invalid")
	end

	scenario "successful edit" do
		login_as(user, :scope => :user)
		visit edit_user_registration_path(user)
		fill_in 'Email', :with => 'newemail@valid.com'
		fill_in 'Current password', :with => user.password
		click_button 'Save changes'
		expect(page).to have_content("Your account has been updated successfully.")
	end

end