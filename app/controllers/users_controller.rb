class UsersController < ApplicationController

  # Don't need to get user object as it's already captured by Devise
  #   current_user
  def show
    # If surgeon, get user's surgeon profile (may be nil if surgeon profile
    #   is not setup yet)
    if current_user.is_surgeon()
      @user_surgeon_profile = UserSurgeonProfile.find_by_user_id(user_params[:id])
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:id)
    end

end
