class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  #layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:name,:email)}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name,:email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  layout :layout_by_resource
  
  def layout_by_resource
    if devise_controller? && resource_name == :user
      "devise_layout"
    else
      "application"
    end
  end
end
