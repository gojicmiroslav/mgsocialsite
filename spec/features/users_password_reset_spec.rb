require 'rails_helper'

RSpec.feature "User Signup", :device do

	let(:user){ FactoryGirl.create(:user) }
	let(:new_password) { 'Passw0rd!' }

	scenario "password reset" do
  	visit new_user_session_path
  	click_on "Forgot your password?"

  	expect(page).to have_content("Forgot your password?")

  	fill_in 'user_email', with: user.email
    expect do
      click_button 'Send me reset password instructions'
    end.to change(ActionMailer::Base.deliveries, :count).by(1)
    
    expect(page).to have_content(I18n.t("devise.passwords.send_instructions"))

    expect(unread_emails_for(user.email)).to be_present
    open_email(user.email, with_subject: 'Reset password instructions')
    click_first_link_in_email
    expect(page).to have_content("Change your password")

    #Invalid password - empty password
	fill_in 'New password', with: ""
    fill_in 'Confirm new password', with: ""
    click_button 'Change my password'    
    expect(page).to have_content("Password can't be blank")

    #Invalid password - empty password, but valid password confirmation
	fill_in 'New password', with: ""
    fill_in 'Confirm new password', with: new_password
    click_button 'Change my password'    
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")

    #Invalid password - empty password confirmation, but valid password
	fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: ""
    click_button 'Change my password'    
    expect(page).to have_content("Password confirmation doesn't match Password")

    #Invalid password - too short password - minimum 5 characters
	fill_in 'New password', with: "123"
    fill_in 'Confirm new password', with: "123"
    click_button 'Change my password'    
    expect(page).to have_content("Password is too short")

    #Invalid password - Password confirmation doesn't match Password
	fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: "1234567"
    click_button 'Change my password'    
    expect(page).to have_content("Password confirmation doesn't match Password")

    fill_in 'New password', with: new_password
    fill_in 'Confirm new password', with: new_password
    click_button 'Change my password'

    expect(page).to have_content(I18n.t("devise.passwords.updated"))
    first(:link, "Logout").click
    first(:link, "Sign In").click

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: new_password

    click_button 'Log In'
    expect(page).to have_content I18n.t("devise.sessions.signed_in")
	end


end