class HealthcareProvidersController < ApplicationController
  before_action :set_healthcare_provider, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /healthcare_providers
  # GET /healthcare_providers.json
  def index
    @healthcare_providers = HealthcareProvider.all
  end

  # GET /healthcare_providers/1
  # GET /healthcare_providers/1.json
  def show
  end

  # GET /healthcare_providers/new
  def new
    @healthcare_provider = HealthcareProvider.new
  end

  # GET /healthcare_providers/1/edit
  def edit
  end

  # POST /healthcare_providers
  # POST /healthcare_providers.json
  def create
    @healthcare_provider = HealthcareProvider.new(healthcare_provider_params)

    respond_to do |format|
      if @healthcare_provider.save
        format.html { redirect_to @healthcare_provider, notice: 'Healthcare provider was successfully created.' }
        format.json { render json: @healthcare_provider }
      else
        format.html { render action: 'new' }
        format.json { render json: @healthcare_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /healthcare_providers/1
  # PATCH/PUT /healthcare_providers/1.json
  def update
    respond_to do |format|
      if @healthcare_provider.update(healthcare_provider_params)
        format.html { redirect_to @healthcare_provider, notice: 'Healthcare provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @healthcare_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /healthcare_providers/1
  # DELETE /healthcare_providers/1.json
  def destroy
    @healthcare_provider.destroy
    respond_to do |format|
      format.html { redirect_to healthcare_providers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_healthcare_provider
      @healthcare_provider = HealthcareProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def healthcare_provider_params
      params.require(:healthcare_provider).permit(:name, :provider_type)
    end
end
