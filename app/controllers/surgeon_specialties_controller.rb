class SurgeonSpecialtiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_surgeon_specialty, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /surgeon_specialties
  # GET /surgeon_specialties.json
  def index
    @surgeon_specialties = SurgeonSpecialty.all
  end

  # GET /surgeon_specialties/1
  # GET /surgeon_specialties/1.json
  def show
  end

  # GET /surgeon_specialties/new
  def new
    @surgeon_specialty = SurgeonSpecialty.new
  end

  # GET /surgeon_specialties/1/edit
  def edit
  end

  # POST /surgeon_specialties
  # POST /surgeon_specialties.json
  def create
    @surgeon_specialty = SurgeonSpecialty.new(surgeon_specialty_params)

    respond_to do |format|
      if @surgeon_specialty.save
        format.html { redirect_to @surgeon_specialty, notice: 'Surgeon specialty was successfully created.' }
        format.json { render action: 'show', status: :created, location: @surgeon_specialty }
      else
        format.html { render action: 'new' }
        format.json { render json: @surgeon_specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgeon_specialties/1
  # PATCH/PUT /surgeon_specialties/1.json
  def update
    respond_to do |format|
      if @surgeon_specialty.update(surgeon_specialty_params)
        format.html { redirect_to @surgeon_specialty, notice: 'Surgeon specialty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @surgeon_specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgeon_specialties/1
  # DELETE /surgeon_specialties/1.json
  def destroy
    @surgeon_specialty.destroy
    respond_to do |format|
      format.html { redirect_to surgeon_specialties_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surgeon_specialty
      @surgeon_specialty = SurgeonSpecialty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surgeon_specialty_params
      params.require(:surgeon_specialty).permit(:name)
    end
end
