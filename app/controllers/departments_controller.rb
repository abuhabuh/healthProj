class DepartmentsController < ApplicationController
  # Not calling authenticate user because departments is loaded with other obj
  #  and user should be authenticated already.
  #  TODO: call authenticate anyways?
  #  TODO: match these filters with cann'd rails filters
  #    - see surgical_profiles_controller.rb
  before_filter :authenticate_user!
  before_action :set_healthcare_provider
  respond_to :html, :xml, :json
  authorize_resource

  # GET /healthcare_providers/:id/departments/:id
  # GET /healthcare_providers/:id/departments/:id.json
  def index
    @departments = @healthcare_provider.departments.all
    respond_with @departments
  end

  # GET /healthcare_providers/:id/departments/1
  # GET /healthcare_providers/:id/departments/1.json
  def show
  end

  # POST /healthcare_providers/:id/departments
  # POST /healthcare_providers/:id/departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        # TODO: log improper html requests here
        format.html { redirect_to @department,
          notice: 'Department was successfully created.' }
        format.json { render json: @department }
      else
        # TODO: process error handling
        format.html { render action: 'new' }
        format.json { render text: "Unable to create department", status: :unprocessable_entity}
      end
    end

  end

  # DELETE /healthcare_providers/:id/departments/1
  # DELETE /healthcare_providers/:id/departments/1.json
  def destroy
    # Using normal params because not passed in through user input
    @department = Department.find(params[:id])
    @department.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :healthcare_provider_id)
    end

    def set_healthcare_provider
      @healthcare_provider = HealthcareProvider.find(params[:healthcare_provider_id])
    end

end