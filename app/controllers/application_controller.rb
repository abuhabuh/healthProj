class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Set parameters for Devise - TODO: change to non-lazy way
  #   https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  before_filter :configure_devise_params, if: :devise_controller?

  # Handle Cancan exception and redirect to homepage
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected
    # Allows custom parameters for Devise controller
    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:first_name, :last_name, :email, :role, :password,
                 :password_confirmation)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:first_name, :last_name, :email, :role, :password,
                 :password_confirmation, :current_password)
      end
    end
end
