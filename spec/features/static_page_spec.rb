require 'rails_helper'

RSpec.describe "Static page", :type => :feature do 

	describe "Home page" do
		it "should have the title Home" do
			visit "static_pages/home"
			expect(page).to have_selector("title",
																		:text => "MG Social Site",
																		:visible => false)
		end
	end

	describe "Help page" do
		it "should have the title Help" do
			visit "static_pages/help"
			expect(page).to have_selector("title",
																		:text => "Help | MG Social Site",
																		:visible => false)
		end
	end

	describe "About page" do	
		it "should have the title About" do
			visit "static_pages/about"
			expect(page).to have_selector("title",
																		:text => "About | MG Social Site",
																		:visible => false)
		end
	end
	
end