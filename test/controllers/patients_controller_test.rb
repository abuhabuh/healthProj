require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  setup do
    @patient = patients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      post :create, patient: { address1: @patient.address1, address2: @patient.address2, cell_phone: @patient.cell_phone, city: @patient.city, date_of_birth: @patient.date_of_birth, ethnicity: @patient.ethnicity, first_name: @patient.first_name, gender: @patient.gender, last_name: @patient.last_name, medical_record_id: @patient.medical_record_id, middle_initial: @patient.middle_initial, phone: @patient.phone, phone_home: @patient.phone_home, language: @patient.language, race: @patient.race, state: @patient.state, time: @patient.time, work_phone: @patient.work_phone }
    end

    assert_redirected_to patient_path(assigns(:patient))
  end

  test "should show patient" do
    get :show, id: @patient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patient
    assert_response :success
  end

  test "should update patient" do
    patch :update, id: @patient, patient: { address1: @patient.address1, address2: @patient.address2, cell_phone: @patient.cell_phone, city: @patient.city, date_of_birth: @patient.date_of_birth, ethnicity: @patient.ethnicity, first_name: @patient.first_name, gender: @patient.gender, last_name: @patient.last_name, medical_record_id: @patient.medical_record_id, middle_initial: @patient.middle_initial, phone: @patient.phone, phone_home: @patient.phone_home, language: @patient.language, race: @patient.race, state: @patient.state, time: @patient.time, work_phone: @patient.work_phone }
    assert_redirected_to patient_path(assigns(:patient))
  end

  test "should destroy patient" do
    assert_difference('Patient.count', -1) do
      delete :destroy, id: @patient
    end

    assert_redirected_to patients_path
  end
end
