class HealthCareProvidersController < ApplicationController
  before_action :set_health_care_provider, only: [:show, :edit, :update, :destroy]

  # GET /health_care_providers
  # GET /health_care_providers.json
  def index
    @health_care_providers = HealthCareProvider.all
  end

  # GET /health_care_providers/1
  # GET /health_care_providers/1.json
  def show
  end

  # GET /health_care_providers/new
  def new
    @health_care_provider = HealthCareProvider.new
  end

  # GET /health_care_providers/1/edit
  def edit
  end

  # POST /health_care_providers
  # POST /health_care_providers.json
  def create
    @health_care_provider = HealthCareProvider.new(health_care_provider_params)

    respond_to do |format|
      if @health_care_provider.save
        format.html { redirect_to @health_care_provider, notice: 'Health care provider was successfully created.' }
        format.json { render action: 'show', status: :created, location: @health_care_provider }
      else
        format.html { render action: 'new' }
        format.json { render json: @health_care_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_care_providers/1
  # PATCH/PUT /health_care_providers/1.json
  def update
    respond_to do |format|
      if @health_care_provider.update(health_care_provider_params)
        format.html { redirect_to @health_care_provider, notice: 'Health care provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @health_care_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_care_providers/1
  # DELETE /health_care_providers/1.json
  def destroy
    @health_care_provider.destroy
    respond_to do |format|
      format.html { redirect_to health_care_providers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_care_provider
      @health_care_provider = HealthCareProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def health_care_provider_params
      params.require(:health_care_provider).permit(:name, :type)
    end
end
