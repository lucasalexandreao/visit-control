class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redireciona para a página de login do Devise
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :role ])
  end
end
