require 'test_helper'

class SurgicalProfilesControllerTest < ActionController::TestCase
  setup do
    @surgical_profile = surgical_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surgical_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surgical_profile" do
    assert_difference('SurgicalProfile.count') do
      post :create, surgical_profile: { anesthesia_technique: @surgical_profile.anesthesia_technique, belongs_to: @surgical_profile.belongs_to, belongs_to: @surgical_profile.belongs_to, cpt_code: @surgical_profile.cpt_code, elective_surgery: @surgical_profile.elective_surgery, encounter_number: @surgical_profile.encounter_number, hospital_admission_date: @surgical_profile.hospital_admission_date, operation_date: @surgical_profile.operation_date, origin_status: @surgical_profile.origin_status, patient_status: @surgical_profile.patient_status, principal_procedure: @surgical_profile.principal_procedure }
    end

    assert_redirected_to surgical_profile_path(assigns(:surgical_profile))
  end

  test "should show surgical_profile" do
    get :show, id: @surgical_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @surgical_profile
    assert_response :success
  end

  test "should update surgical_profile" do
    patch :update, id: @surgical_profile, surgical_profile: { anesthesia_technique: @surgical_profile.anesthesia_technique, belongs_to: @surgical_profile.belongs_to, belongs_to: @surgical_profile.belongs_to, cpt_code: @surgical_profile.cpt_code, elective_surgery: @surgical_profile.elective_surgery, encounter_number: @surgical_profile.encounter_number, hospital_admission_date: @surgical_profile.hospital_admission_date, operation_date: @surgical_profile.operation_date, origin_status: @surgical_profile.origin_status, patient_status: @surgical_profile.patient_status, principal_procedure: @surgical_profile.principal_procedure }
    assert_redirected_to surgical_profile_path(assigns(:surgical_profile))
  end

  test "should destroy surgical_profile" do
    assert_difference('SurgicalProfile.count', -1) do
      delete :destroy, id: @surgical_profile
    end

    assert_redirected_to surgical_profiles_path
  end
end
