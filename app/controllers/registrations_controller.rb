class RegistrationsController < Devise::RegistrationsController

  # Override default Devise update to allow update without password
  #   https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:current_password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
      account_update_params.delete("current_password")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to :back
    else
      render "edit"
    end
  end

end