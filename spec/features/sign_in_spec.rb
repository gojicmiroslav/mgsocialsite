require 'rails_helper'

# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
RSpec.feature "Site layout", :type => :feature do
	
	# Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    user = User.create(email: "someone@example.tld", password: "somepassword")
    signin('invalid@email.com', user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end
  
end