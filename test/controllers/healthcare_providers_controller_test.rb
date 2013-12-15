require 'test_helper'

class HealthCareProvidersControllerTest < ActionController::TestCase
  setup do
    @healthcare_provider = healthcare_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:healthcare_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create healthcare_provider" do
    assert_difference('HealthCareProvider.count') do
      post :create, healthcare_provider: { name: @healthcare_provider.name, type: @healthcare_provider.type }
    end

    assert_redirected_to healthcare_provider_path(assigns(:healthcare_provider))
  end

  test "should show healthcare_provider" do
    get :show, id: @healthcare_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @healthcare_provider
    assert_response :success
  end

  test "should update healthcare_provider" do
    patch :update, id: @healthcare_provider, healthcare_provider: { name: @healthcare_provider.name, type: @healthcare_provider.type }
    assert_redirected_to healthcare_provider_path(assigns(:healthcare_provider))
  end

  test "should destroy healthcare_provider" do
    assert_difference('HealthCareProvider.count', -1) do
      delete :destroy, id: @healthcare_provider
    end

    assert_redirected_to healthcare_providers_path
  end
end
