class PatientsController < ApplicationController
  before_filter :authenticate_user!
  # TODO: read up on before_action:
  #  http://guides.rubyonrails.org/action_controller_overview.html
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all

    respond_with(@patients)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, 
          notice: 'Patient was successfully created.' }
        format.json { render action: 'show', 
          status: :created, location: @patient }
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
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
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
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:medical_record_id, :last_name, :first_name, :middle_initial, :address1, :address2, :city, :state, :phone_home, :phone, :work_phone, :cell_phone, :date_of_birth, :time, :gender, :race, :ethnicity, :preferred_language)
    end
end
