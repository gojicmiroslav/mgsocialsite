class RegistrationsController < Devise::RegistrationsController

	protected

  def after_sign_up_path_for(resource)
    resource
  end

  def authenticate_scope!
    session[:forwarding_url] = request.url if request.get?
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    session.delete(:forwarding_url) if session.key?(:forwarding_url)

    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

end
