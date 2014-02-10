class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json
  authorize_resource

  # GET /patients - returns html page to render patients view
  # GET /patients.json
  def index
    # Paginate patients - set page we're on
    page = 1
    if params.has_key?(:page)
      page = params[:page]
    end

    @patients = Patient.query_all_patients(current_user, page)
    @show_single = false

    # load selector arrays for displaying patient data
    load_patient_selector_arrays()

    respond_with @patients
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    # load selector arrays for displaying patient data
    load_patient_selector_arrays

    @show_single = true
  end

  # GET /patients/new
  def new
    # load selector arrays for displaying patient data
    load_patient_selector_arrays

    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
    # load selector arrays for displaying patient data
    load_patient_selector_arrays

  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.preprocess_and_save
        format.html { redirect_to @patient,
          notice: 'Patient was successfully created.' }
        format.json { render json: @patient, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @patient.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.preprocess_and_update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render json: @patient, status: :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.query_one_by_id(current_user, params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white
    #   list through.
    def patient_params
      params.require(:patient).permit(
        :medical_record_id, :last_name, :first_name, :middle_initial,
        :address1, :address2, :city, :state, :home_phone, :phone,
        :work_phone, :cell_phone, :date_of_birth, :time, :gender,
        :race_id, :ethnicity_id, :language_id
      )

    end

    def load_patient_selector_arrays
      @races_selector_array = Race.get_all_races_selector_array()
      @ethnicities_selector_array = Ethnicity.get_all_ethnicities_selector_array()
      @languages_selector_array = Language.get_all_languages_selector_array()
    end

end
