require 'rails_helper'

RSpec.describe "Static page", :type => :feature do 

	describe "Home page" do
		it "should have the title Home" do
			visit root_path
			expect(page).to have_selector("title", :text => full_title, :visible => false)
		end

		it "should have tag Header and Footer" do
			visit root_path
			expect(page).to have_selector("header")
			expect(page).to have_selector("footer")
		end

		it "should have register form" do
			visit root_path
			expect(page).to have_content("Log In")
			expect(page).to have_link("Forgot your password?")
		end

		it "should have login form" do
			visit root_path
			expect(page).to have_xpath("//input[@value='Create my account']")
		end
	end

	describe "Help page" do
		it "should have the title Help" do
			visit root_path

			click_link "Help"
			
			expect(page).to have_css("h1", text: "Help")
			expect(page).to have_selector("title", :text => full_title("Help"), :visible => false)
		end
	end

	describe "About page" do	
		it "should have the title About" do
			visit root_path

			click_link "About"

			expect(page).to have_css("h1", text: "About")
			expect(page).to have_selector("title", :text => full_title("About"), :visible => false)
		end
	end

	describe "Contact page" do	
		it "should have the title About" do
			visit root_path

			click_link "Contact"

			expect(page).to have_css("h1", text: "Contact")
			expect(page).to have_selector("title", :text => full_title("Contact"), :visible => false)
		end
	end

	describe "Sign Up page" do	
		it "should have the title Sign Up" do
			visit register_path
			expect(page).to have_css("h1", text: "Register")
			expect(page).to have_selector("title", :text => full_title("Register"), :visible => false)
		end
	end
	
end