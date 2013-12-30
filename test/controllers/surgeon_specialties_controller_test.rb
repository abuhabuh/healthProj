require 'test_helper'

class SurgeonSpecialtiesControllerTest < ActionController::TestCase
  setup do
    @surgeon_specialty = surgeon_specialties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surgeon_specialties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surgeon_specialty" do
    assert_difference('SurgeonSpecialty.count') do
      post :create, surgeon_specialty: { name: @surgeon_specialty.name }
    end

    assert_redirected_to surgeon_specialty_path(assigns(:surgeon_specialty))
  end

  test "should show surgeon_specialty" do
    get :show, id: @surgeon_specialty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @surgeon_specialty
    assert_response :success
  end

  test "should update surgeon_specialty" do
    patch :update, id: @surgeon_specialty, surgeon_specialty: { name: @surgeon_specialty.name }
    assert_redirected_to surgeon_specialty_path(assigns(:surgeon_specialty))
  end

  test "should destroy surgeon_specialty" do
    assert_difference('SurgeonSpecialty.count', -1) do
      delete :destroy, id: @surgeon_specialty
    end

    assert_redirected_to surgeon_specialties_path
  end
end
