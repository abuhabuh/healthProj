class UsersController < ApplicationController

  # Don't need to get user object as it's already captured by Devise
  #   current_user
  def show
    @roles = current_user.query_roles()

    # If surgeon, get user's surgeon profile (may be nil if surgeon profile
    #   is not setup yet)
    if current_user.is_surgeon()
      @user_surgeon_profile =
        UserSurgeonProfile.query_one_by_user_id(user_params[:id])

      @surgeon_specialty_name = 'Not set'
      if @user_surgeon_profile
        @surgeon_specialty_name =
          SurgeonSpecialty.query_specialty_name(
            @user_surgeon_profile.surgeon_specialty_id
            )
      end

      # TODO - don't load this every time from DB (cache)
      @specialties_list = Array.new
      surgeon_specialties = SurgeonSpecialty.all
      surgeon_specialties.map { |specialty| @specialties_list.push([specialty.name, specialty.id])}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:id)
    end

end
