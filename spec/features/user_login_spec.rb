require 'rails_helper'

RSpec.feature "User Login", :device do

	scenario "login with invalid information" do		
		visit new_user_session_path
		expect(page).to have_css("h1", text: "Log In")
		expect(page).to have_title("Log In | MG Social Site")

		signin("someone@invalid", "somepassword", false)

		expect(page).not_to have_content("Signed in successfully.")
		expect(page).to have_content("Invalid email or password.")
		expect(page).to have_css('div.alert')

		visit root_path

		expect(page).not_to have_css('div.alert')
	end

	scenario "login with valid information followed by logout" do
		user = FactoryGirl.create(:user)

		visit "/"
		expect(page).to have_content("Sign In")

		visit new_user_session_path
		expect(page).to have_css("h1", text: "Log In")
		expect(page).to have_title("Log In | MG Social Site")

		signin(user.email, user.password, false)
		
		expect(page).to have_content("Signed in successfully.")
		expect(page).not_to have_content("Invalid email or password.")
		expect(page).to have_css('div.alert', text: "Signed in successfully.")

		click_on "Logout"

		expect(page).to have_content("Signed out successfully.")
		expect(page).to have_css('div.alert')
		expect(page.current_url).to eq(root_url)
	end

	scenario "login with remembering" do
		user = FactoryGirl.create(:user)

		visit "/"
		expect(page).to have_content("Sign In")

		visit new_user_session_path
		expect(page).to have_css("h1", text: "Log In")
		expect(page).to have_title("Log In | MG Social Site")

		signin(user.email, user.password, true)

		expect(get_me_the_cookie("remember_user_token")).not_to be_nil
		
		expect(page).to have_content("Signed in successfully.")
		expect(page).not_to have_content("Invalid email or password.")
		expect(page).to have_css('div.alert', text: "Signed in successfully.")

		expire_cookies

		visit "/"

		expect(page).to have_content("Logout")

		#show_me_the_cookies
		#print get_me_the_cookies
		#print get_me_the_cookie("remember_user_token")
		#print user.rememberable_value
	end

	scenario "login without remembering" do
		user = FactoryGirl.create(:user)

		visit "/"
		expect(page).to have_content("Sign In")

		visit new_user_session_path
		expect(page).to have_css("h1", text: "Log In")
		expect(page).to have_title("Log In | MG Social Site")

		signin(user.email, user.password, false)

		expect(get_me_the_cookie("remember_user_token")).to be_nil
		
		expect(page).to have_content("Signed in successfully.")
		expect(page).not_to have_content("Invalid email or password.")
		expect(page).to have_css('div.alert', text: "Signed in successfully.")

		expire_cookies

		visit "/"

		expect(page).not_to have_content("Logout")
		expect(page).to have_content("Sign In")

		#show_me_the_cookies
		#print get_me_the_cookies
		#print get_me_the_cookie("remember_user_token")
		#print user.rememberable_value
	end

	scenario "friendly forwarding after successful log in" do
		visit edit_user_registration_path
		expect(current_path).to eq(new_user_session_path)
		user = FactoryGirl.create(:user)
		signin(user.email, user.password, false)
		# vracamo se na pocetni url koji je korisnik uneo
		expect(current_path).to eq(edit_user_registration_path)
	end

end