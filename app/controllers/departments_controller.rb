class DepartmentsController < ApplicationController
  # Not calling authenticate user because departments is loaded with other obj
  #  and user should be authenticated already. 
  #  TODO: call authenticate anyways?
  before_filter :load_healthcare_provider
  respond_to :html, :xml, :json

  # GET /healthcare_providers/:id/departments/:id
  # GET /healthcare_providers/:id/departments/:id.json
  def index
    @departments = @healthcare_provider.departments.all
    puts "@@@ getting departments"
    puts @departments.inspect()
    respond_with(@departments)
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end


  # POST /departments
  # POST /departments.json
  def create
    puts "@@@ here"
    puts "@@@ dpt params: " + department_params.inspect()
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @country = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      print "@@@ department_params - function"
      print params.inspect()
      params.require(:department).permit(:name, :healthcare_provider_id)
    end

    def load_healthcare_provider
      @healthcare_provider = HealthcareProvider.find(params[:healthcare_provider_id])
    end


end