require 'rails_helper'

RSpec.feature "User Login", :device do

	scenario "login with invalid information" do
		#visit '/'
		#click_link "Sign In"
		#expect(page).to have_css("h1", text: "Log In")
		visit new_user_session_path
		expect(page).to have_css("h1", text: "Log In")
		expect(page).to have_title("Log In | MG Social Site")

		login("someone@invalid", "somepassword", false)

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

		login(user.email, user.password, false)
		
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

		login(user.email, user.password, true)

		#expect(session[:user_id]).not_to be_nil
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

		login(user.email, user.password, false)

		#expect(session[:user_id]).not_to be_nil
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

	private 

	def login(email, password, remember_me)
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		check("Remember me") if remember_me
		click_button "Log In"
	end

	def logged_as(user)
    page.set_rack_session('warden.user.user.key' => User.serialize_into_session(user).unshift("User"))
  end

end