###
# Description
#
# Index handler
# - Can show profiles for a specific patient
# - Can show profiles for a specific surgeon
###

class SurgicalProfilesController < ApplicationController
  before_action :set_patient_and_profile,
    only: [:show, :edit, :update, :destroy, :new, :index]
  respond_to :html, :xml, :json
  authorize_resource

  # GET /patients/:id/surgical_profiles
  # GET /patients/:id/surgical_profiles.json
  # GET /surgical_profiles
  def index
    # Template has to handel:
    # - Display profiles for a patient
    # - Display profiles for a surgeon
    @surgical_profiles = nil
    if @came_from_patient_page
      @surgical_profiles =
        @patient.query_surgical_profiles(current_user)
    else
      @surgical_profiles =
        SurgicalProfile.query_surgical_profiles_by_surgeon(current_user)
    end
    respond_with @surgical_profiles
  end

  # GET /patients/:id/surgical_profiles/1
  # GET /patients/:id/surgical_profiles/1.json
  # GET /surgical_profiles/1
  def show
    @surgeon = User.find(@surgical_profile.user_id)
  end

  # GET /patients/:id/surgical_profiles/new
  def new
    @surgical_profile = SurgicalProfile.new
    # Create list of surgeons for selector on frontend
    @surgeons_selector_arr = User.query_surgeons_selector_array()
  end

  # GET /patients/:id/surgical_profiles/1/edit
  def edit
    @surgeon = User.find(@surgical_profile.user_id)
    # Create list of surgeons for selector on frontend
    @surgeons_selector_arr = User.query_surgeons_selector_array()
  end

  # POST /patients/:id/surgical_profiles
  # POST /patients/:id/surgical_profiles.json
  def create
    @surgical_profile = SurgicalProfile.new(surgical_profile_params)

    # TODO: minimize into single query
    @patient = Patient.query_patient_by_id(
      current_user, @surgical_profile.patient_id
      )
    @surgeon = User.find(@surgical_profile.user_id)

    respond_to do |format|
      if @surgical_profile.save
        format.html { redirect_to patient_surgical_profiles_path(@patient), notice: 'Surgical profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @surgical_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/:id/surgical_profiles/1
  # PATCH/PUT /patients/:id/surgical_profiles/1.json
  def update
    respond_to do |format|
      if @surgical_profile.update(surgical_profile_params)
        format.html { redirect_to patient_surgical_profile_path(@patient, @surgical_profile),
          notice: 'Surgical profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/:id/surgical_profiles/1
  # DELETE /patients/:id/surgical_profiles/1.json
  def destroy
    @surgical_profile.destroy
    respond_to do |format|
      format.html { redirect_to patient_surgical_profiles_path(@patient) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_and_profile
      @came_from_patient_page = params.has_key?(:patient_id)

      # Set surgical profile
      @surgical_profile = nil
      if params.has_key?(:id)
        @surgical_profile =
          SurgicalProfile.query_surgical_profile_by_id(
            current_user, params[:id]
            )
      end

      # Set patient
      # - from url if navigating from patient page
      # - from surgical_profile if not (and surgical profile exists)
      @patient = nil
      if @came_from_patient_page
        @patient = Patient.query_patient_by_id(current_user, params[:patient_id])
      else
        if @surgical_profile
          @patient = Patient.query_patient_by_id(current_user, @surgical_profile.patient_id)
        end
      end
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
