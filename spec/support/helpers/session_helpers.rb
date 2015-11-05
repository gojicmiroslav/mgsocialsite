module Features
	module SessionHelpers

    def signin(email, password, remember_me = false)
	    visit new_user_session_path
	    fill_in 'Email', with: email
	    fill_in 'Password', with: password
	    check("Remember me") if remember_me
	    click_button 'Log In'
	  end

	  def logged_as(user)
	    page.set_rack_session('warden.user.user.key' => User.serialize_into_session(user).unshift("User"))
	  end
	end
end