require 'test_helper'

class HealthCareProvidersControllerTest < ActionController::TestCase
  setup do
    @health_care_provider = health_care_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:health_care_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create health_care_provider" do
    assert_difference('HealthCareProvider.count') do
      post :create, health_care_provider: { name: @health_care_provider.name, type: @health_care_provider.type }
    end

    assert_redirected_to health_care_provider_path(assigns(:health_care_provider))
  end

  test "should show health_care_provider" do
    get :show, id: @health_care_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @health_care_provider
    assert_response :success
  end

  test "should update health_care_provider" do
    patch :update, id: @health_care_provider, health_care_provider: { name: @health_care_provider.name, type: @health_care_provider.type }
    assert_redirected_to health_care_provider_path(assigns(:health_care_provider))
  end

  test "should destroy health_care_provider" do
    assert_difference('HealthCareProvider.count', -1) do
      delete :destroy, id: @health_care_provider
    end

    assert_redirected_to health_care_providers_path
  end
end
