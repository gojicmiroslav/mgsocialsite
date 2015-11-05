module Features
	module RegistrationHelpers

		def sign_up(name, email, password, password_confirmation, link_button)
			fill_in 'Name',  with: name
			fill_in 'Email', with: email
			fill_in 'Password', with: password
			fill_in 'Password confirmation', with: password_confirmation
			click_button link_button
		end

	end
end