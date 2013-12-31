require 'test_helper'

class UserSurgeonProfilesControllerTest < ActionController::TestCase
  setup do
    @user_surgeon_profile = user_surgeon_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_surgeon_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_surgeon_profile" do
    assert_difference('UserSurgeonProfile.count') do
      post :create, user_surgeon_profile: { belongs_to: @user_surgeon_profile.belongs_to, belongs_to: @user_surgeon_profile.belongs_to }
    end

    assert_redirected_to user_surgeon_profile_path(assigns(:user_surgeon_profile))
  end

  test "should show user_surgeon_profile" do
    get :show, id: @user_surgeon_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_surgeon_profile
    assert_response :success
  end

  test "should update user_surgeon_profile" do
    patch :update, id: @user_surgeon_profile, user_surgeon_profile: { belongs_to: @user_surgeon_profile.belongs_to, belongs_to: @user_surgeon_profile.belongs_to }
    assert_redirected_to user_surgeon_profile_path(assigns(:user_surgeon_profile))
  end

  test "should destroy user_surgeon_profile" do
    assert_difference('UserSurgeonProfile.count', -1) do
      delete :destroy, id: @user_surgeon_profile
    end

    assert_redirected_to user_surgeon_profiles_path
  end
end
