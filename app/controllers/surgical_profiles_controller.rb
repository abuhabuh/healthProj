class SurgicalProfilesController < ApplicationController
  before_action :set_surgical_profile, only: [:show, :edit, :update, :destroy]

  # GET /surgical_profiles
  # GET /surgical_profiles.json
  def index
    @surgical_profiles = SurgicalProfile.all
  end

  # GET /surgical_profiles/1
  # GET /surgical_profiles/1.json
  def show
  end

  # GET /surgical_profiles/new
  def new
    @surgical_profile = SurgicalProfile.new
    
  end

  # GET /surgical_profiles/1/edit
  def edit
  end

  # POST /surgical_profiles
  # POST /surgical_profiles.json
  def create
    @surgical_profile = SurgicalProfile.new(surgical_profile_params)

    respond_to do |format|
      if @surgical_profile.save
        format.html { redirect_to @surgical_profile, notice: 'Surgical profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @surgical_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgical_profiles/1
  # PATCH/PUT /surgical_profiles/1.json
  def update
    respond_to do |format|
      if @surgical_profile.update(surgical_profile_params)
        format.html { redirect_to @surgical_profile, notice: 'Surgical profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgical_profiles/1
  # DELETE /surgical_profiles/1.json
  def destroy
    @surgical_profile.destroy
    respond_to do |format|
      format.html { redirect_to surgical_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surgical_profile
      @surgical_profile = SurgicalProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surgical_profile_params
      params.require(:surgical_profile).permit(
        :user_id, :patient_id, :patient_status, :elective_surgery,
        :principal_procedure, :cpt_code, :origin_status, :hospital_admission_date,
        :operation_date, :anesthesia_technique, :encounter_number
        )
    end
end
