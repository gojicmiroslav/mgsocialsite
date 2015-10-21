class SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    url = session[:forwarding_url]
    session.delete(:forwarding_url)
    url || resource
  end

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message :notice, :already_signed_out if is_flashing_format?
      respond_to_on_destroy
    end
  end

end
