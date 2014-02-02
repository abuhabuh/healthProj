class SurgicalProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_patient_and_profile,
    only: [:show, :edit, :update, :destroy, :new, :index]
  respond_to :html, :xml, :json
  authorize_resource

  ###
  # Constants
  ###
  # Controls what data for surgical profile is displayed on view
  # TODO: change these to descriptive strings (or revert to int)
  SP_VIEW_GENERAL = '0'
  SP_VIEW_PREOP_ASSESSMENT = '1'
  SP_VIEW_OPERATIVE = '2'
  SP_VIEW_DISCHARGE = '3'
  SP_VIEW_FOLLOW_UP = '4'

  # GET /patients/:patient_id/surgical_profiles
  # GET /patients/:patient_id/surgical_profiles.json
  # GET /surgical_profiles
  def index
    # Template has to handel:
    # - Display profiles for a patient
    # - Display profiles for a surgeon
    @surgical_profiles = nil
    if @show_for_patient
      @surgical_profiles =
        @patient.query_surgical_profiles_inc_patients(current_user)
    else
      @surgeon = current_user
      @surgical_profiles =
        SurgicalProfile.query_all_by_surgeon_inc_patients(current_user)
    end
    respond_with @surgical_profiles
  end

  # GET /patients/:patient_id/surgical_profiles/1
  # GET /patients/:patient_id/surgical_profiles/1.json
  # GET /surgical_profiles/1
  #
  # Controls views for all sub information including risk assessment,
  #   operative info, discharge, etc
  # - dependent on :sp_view parameter
  def show
    # Set what section of surgical profile (what tab) we're viewing
    @sp_view_mode = SP_VIEW_GENERAL
    if params.has_key?('sp_view_mode')
      @sp_view_mode = params[:sp_view_mode]
    end

    # Load appropriate data according to view needed
    case @sp_view_mode
    when SP_VIEW_PREOP_ASSESSMENT
      @preop_risk_assessments =
        PreopRiskAssessment.query_all_by_surgical_profile(
          current_user, @surgical_profile
          )
    when SP_VIEW_OPERATIVE

    when SP_VIEW_DISCHARGE

    when SP_VIEW_FOLLOW_UP

    else
      # Render default (SP_VIEW_GENERAL)
    end

    # Get the surgeon
    @surgeon = User.query_one_surgeon_by_id(@surgical_profile.user_id)
  end

  # GET /patients/:patient_id/surgical_profiles/new
  def new
    @surgical_profile = SurgicalProfile.new
    # Create list of surgeons for selector on frontend
    @surgeons_selector_arr = User.query_surgeons_selector_array()
  end

  # GET /patients/:patient_id/surgical_profiles/1/edit
  def edit
    @surgeon = User.find(@surgical_profile.user_id)
    # Create list of surgeons for selector on frontend
    @surgeons_selector_arr = User.query_surgeons_selector_array()
  end

  # POST /patients/:patient_id/surgical_profiles
  # POST /patients/:patient_id/surgical_profiles.json
  def create
    @surgical_profile = SurgicalProfile.new(surgical_profile_params)

    # TODO: minimize into single query
    @patient = Patient.query_one_by_id(
      current_user, @surgical_profile.patient_id
      )
    @surgeon = User.find(@surgical_profile.user_id)

    respond_to do |format|
      if @surgical_profile.preprocess_and_save()
        format.html { redirect_to patient_surgical_profiles_path(@patient), notice: 'Surgical profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @surgical_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/:patient_id/surgical_profiles/1
  # PATCH/PUT /patients/:patient_id/surgical_profiles/1.json
  def update
    respond_to do |format|
      if @surgical_profile.preprocess_and_update(surgical_profile_params)
        format.html { redirect_to patient_surgical_profile_path(@patient, @surgical_profile),
          notice: 'Surgical profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @surgical_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/:patient_id/surgical_profiles/1
  # DELETE /patients/:patient_id/surgical_profiles/1.json
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
      @show_for_patient = params.has_key?(:patient_id)

      # Set surgical profile
      @surgical_profile = nil
      if params.has_key?(:id)
        @surgical_profile =
          SurgicalProfile.query_one_by_id(
            current_user, params[:id]
            )
      end

      # Set patient
      # - from url if navigating from patient page
      # - from surgical_profile if not (and surgical profile exists)
      if @show_for_patient
        @patient = Patient.query_one_by_id(current_user, params[:patient_id])
      else
        if @surgical_profile
          @patient = Patient.query_one_by_id(current_user, @surgical_profile.patient_id)
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
