require 'rails_helper'

RSpec.feature "User Signup", :device do
	
	given(:invalid_user) do
		User.create(name: "", 
								email: 'user@invalid', 
								password: 'foo',
								password_confirmation: "bar") 
	end

	given(:valid_user) do
		User.create(name: "Test User",
								email: "test@gmail.com",
								password: "password",
								password_confirmation: "password")
	end

	scenario "invalid signup information" do
		visit "/"
		click_link "Sign Up"
		expect(page).to have_css("h1", text: "Sign Up")
		expect(current_path).to eq(new_user_registration_path)

		#visit new_user_registration_path
		#before_count = User.count

		expect do
			sign_up(invalid_user.name, invalid_user.email, invalid_user.password, 
							invalid_user.password_confirmation, 'Create my account')
		end.not_to change{User.count}
	end

	scenario "valid signup information should change database" do
		visit new_user_registration_path
		expect(page).to have_content("Sign Up")

		expect do
			sign_up(valid_user.name, valid_user.email, valid_user.password, 
							valid_user.password_confirmation, 'Create my account')
		end.to change{User.count}.from(User.count).to(User.count + 1)
	end

	scenario 'visitor can sign up with valid email address and password' do
		visit new_user_registration_path
    sign_up('Test user', 'test@example.com', 'please123', 'please123', 'Create my account')
    txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    expect(page.current_path).to have_content('users')
  end

	private

	def sign_up(name, email, password, password_confirmation, link_button)
		fill_in 'Name',  with: name
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		fill_in 'Password confirmation', with: password_confirmation
		click_button link_button
	end
end