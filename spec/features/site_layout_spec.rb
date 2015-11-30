require 'rails_helper'

RSpec.describe "Site layout", :type => :feature do
		
	context "GET home" do
		it "should have root,help,about and contact link on home page" do
			visit root_path
			expect(page).to have_link("", :href => root_path, :count => 2)
			expect(page).to have_link("Help", :href => help_path)
			expect(page).to have_link("About", :href => about_path)
			expect(page).to have_link("Contact", :href => contact_path)
			expect(page).to have_link("Log In", :href => login_path)
			expect(page).to have_link("Register", :href => register_path)
		end	

	end

end