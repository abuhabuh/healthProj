class SurgicalProfilesController < ApplicationController
  before_action :set_patient, only: [:new, :index, :show, :edit, :update, :destroy]
  before_action :set_surgical_profile, only: [:destroy, :update, :edit, :show]
  respond_to :html, :xml, :json

  # GET /patients/:id/surgical_profiles
  # GET /patients/:id/surgical_profiles.json
  def index
    @surgical_profiles = @patient.surgical_profiles.all
    respond_with @surgical_profiles
  end

  # GET /patients/:id/surgical_profiles/1
  # GET /patients/:id/surgical_profiles/1.json
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
    @surgeon = User.find(@surgical_profile.user_id)
    @patient = Patient.find(@surgical_profile.patient_id)

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
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

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
