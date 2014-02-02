require 'test_helper'

class PreopRiskAssessmentsControllerTest < ActionController::TestCase
  setup do
    @preop_risk_assessment = preop_risk_assessments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preop_risk_assessments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preop_risk_assessment" do
    assert_difference('PreopRiskAssessment.count') do
      post :create, preop_risk_assessment: { bit_field: @preop_risk_assessment.bit_field, diabetes_mellitus: @preop_risk_assessment.diabetes_mellitus, functional_health_status: @preop_risk_assessment.functional_health_status, height: @preop_risk_assessment.height, sepsis_within_48hrs: @preop_risk_assessment.sepsis_within_48hrs, surgical_profile_id: @preop_risk_assessment.surgical_profile_id, weight: @preop_risk_assessment.weight }
    end

    assert_redirected_to preop_risk_assessment_path(assigns(:preop_risk_assessment))
  end

  test "should show preop_risk_assessment" do
    get :show, id: @preop_risk_assessment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preop_risk_assessment
    assert_response :success
  end

  test "should update preop_risk_assessment" do
    patch :update, id: @preop_risk_assessment, preop_risk_assessment: { bit_field: @preop_risk_assessment.bit_field, diabetes_mellitus: @preop_risk_assessment.diabetes_mellitus, functional_health_status: @preop_risk_assessment.functional_health_status, height: @preop_risk_assessment.height, sepsis_within_48hrs: @preop_risk_assessment.sepsis_within_48hrs, surgical_profile_id: @preop_risk_assessment.surgical_profile_id, weight: @preop_risk_assessment.weight }
    assert_redirected_to preop_risk_assessment_path(assigns(:preop_risk_assessment))
  end

  test "should destroy preop_risk_assessment" do
    assert_difference('PreopRiskAssessment.count', -1) do
      delete :destroy, id: @preop_risk_assessment
    end

    assert_redirected_to preop_risk_assessments_path
  end
end
