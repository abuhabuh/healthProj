class UserSurgeonProfilesController < ApplicationController
  before_action :set_user_surgeon_profile, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /user_surgeon_profiles
  # GET /user_surgeon_profiles.json
  def index
    @user_surgeon_profiles = UserSurgeonProfile.all
  end

  # GET /user_surgeon_profiles/1
  # GET /user_surgeon_profiles/1.json
  def show
  end

  # GET /user_surgeon_profiles/new
  def new
    @user_surgeon_profile = UserSurgeonProfile.new
  end

  # GET /user_surgeon_profiles/1/edit
  def edit
  end

  # POST /user_surgeon_profiles
  # POST /user_surgeon_profiles.json
  def create
    @user_surgeon_profile = UserSurgeonProfile.new(user_surgeon_profile_params)

    respond_to do |format|
      if @user_surgeon_profile.save
        format.html { redirect_to :back, notice: 'User surgeon profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_surgeon_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_surgeon_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_surgeon_profiles/1
  # PATCH/PUT /user_surgeon_profiles/1.json
  def update
    respond_to do |format|
      if @user_surgeon_profile.update(user_surgeon_profile_params)
        format.html { redirect_to @user_surgeon_profile, notice: 'User surgeon profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_surgeon_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_surgeon_profiles/1
  # DELETE /user_surgeon_profiles/1.json
  def destroy
    @user_surgeon_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_surgeon_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_surgeon_profile
      @user_surgeon_profile = UserSurgeonProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_surgeon_profile_params
      params.permit(:surgeon_specialty_id, :user_id)
    end
end
