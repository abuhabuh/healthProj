class PreopRiskAssessmentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sp_and_preop_risk_assessment,
    only: [:show, :edit, :update, :destroy, :new, :index, :create]
  authorize_resource

  # GET /surgical_profiles/:sp_id/preop_risk_assessments
  # GET /surgical_profiles/:sp_id/preop_risk_assessments.json
  # TODO: not used - Return to home page?
  def index
    @preop_risk_assessments =
      PreopRiskAssessment.query_all_by_surgical_profile(
        current_user, @surgical_profile)
  end

  # GET /surgical_profiles/:sp_id/preop_risk_assessments/1
  # GET /surgical_profiles/:sp_id/preop_risk_assessments/1.json
  # TODO: not used - Return to home page?
  def show
  end

  # GET /surgical_profiles/:sp_id/preop_risk_assessments/new
  def new
    @preop_risk_assessment = PreopRiskAssessment.new
  end

  # GET /surgical_profiles/:sp_id/preop_risk_assessments/1/edit
  def edit
  end

  # POST /surgical_profiles/:sp_id/preop_risk_assessments
  # POST /surgical_profiles/:sp_id/preop_risk_assessments.json
  def create
    @preop_risk_assessment =
      PreopRiskAssessment.new(preop_risk_assessment_params)
    @preop_risk_assessment[:surgical_profile_id] = @surgical_profile.id

    respond_to do |format|
      if @preop_risk_assessment.save
        format.html {
          redirect_to patient_surgical_profile_path(
                        @surgical_profile.patient_id,
                        @surgical_profile.id,
                        :sp_view_mode =>
                          SurgicalProfilesController::SP_VIEW_PREOP_ASSESSMENT
          ),
          notice: 'Preop risk assessment was successfully created.' }
        format.json { render action: 'show', status: :created,
          location: @preop_risk_assessment }
      else
        format.html { render action: 'new' }
        format.json { render json: @preop_risk_assessment.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgical_profiles/:sp_id/preop_risk_assessments/1
  # PATCH/PUT /surgical_profiles/:sp_id/preop_risk_assessments/1.json
  def update
    respond_to do |format|
      if @preop_risk_assessment.update(preop_risk_assessment_params)
        format.html {
          redirect_to patient_surgical_profile_path(
                        @surgical_profile.patient_id,
                        @surgical_profile.id,
                        :sp_view_mode =>
                          SurgicalProfilesController::SP_VIEW_PREOP_ASSESSMENT
          ),
          notice: 'Preop risk assessment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @preop_risk_assessment.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgical_profiles/:sp_id/preop_risk_assessments/1
  # DELETE /surgical_profiles/:sp_id/preop_risk_assessments/1.json
  def destroy
    @preop_risk_assessment.destroy
    respond_to do |format|
      format.html {
        redirect_to patient_surgical_profile_path(
                      @surgical_profile.patient_id,
                      @surgical_profile.id,
                      :sp_view_mode =>
                        SurgicalProfilesController::SP_VIEW_PREOP_ASSESSMENT
        ),
        notice: 'Preop risk assessment was successfully deleted.'
        }
      format.html {
        redirect_to preop_risk_assessments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sp_and_preop_risk_assessment
      @surgical_profile =
        SurgicalProfile.query_one_by_id(
          current_user, params[:surgical_profile_id])

      # In the case of /new and /index, we don't have :id
      if params.has_key?(:id)
        @preop_risk_assessment =
          PreopRiskAssessment.query_one_by_id(current_user, params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the
    #   white list through.
    def preop_risk_assessment_params
      # TODO: require the correct field values
      params.require(:preop_risk_assessment).permit(
        :surgical_profile_id, :height, :weight,
        :diabetes_mellitus, :functional_health_status, :sepsis_within_48hrs,
        :current_smoker_within_1yr, :dyspnea_1yr,
        :ventilator_dependent_within_48hrs, :history_of_severe_copd,
        :ascites_within_30days, :chf_within_30days,
        :hypertension_requiring_medications, :acute_renal_failure,
        :requiring_dialysis_within_2wks, :dis_ca, :open_wound,
        :steriod_or_immunosuppressant_for_chronic,
        :significant_body_weight_loss_last_6mos, :bleeding_disorders,
        :preop_transfusion_rbc_within_72hrs, :gerd_meds_within_30days,
        :gallstone_disease, :ambulation_limited, :activity_limited_by_pain,
        :requires_daily_medication,
        :surgical_intervention_planned_or_performed)
    end
end
