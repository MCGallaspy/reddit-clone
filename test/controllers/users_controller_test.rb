require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    log_in_as @user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "gosh@example.com", password: "hahaha", password_confirmation: "hahaha", username: "unique_user" }
    end

    assert_redirected_to root_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: "gosh@example.com", password: "hahaha", password_confirmation: "hahaha" }
    assert_redirected_to edit_user_path(assigns(:user))
  end
  
  test "username should not be updatable, should render edit action" do
    patch :update, id: @user, user: { username: "blargle" }
    assert_template :edit
  end
  
  test "invalid update data should render edit action" do
    patch :update, id: @user, user: { email: "bad@email" }
    assert_template :edit
    
    patch :update, id: @user, user: { password: "a"*5 }
    assert_template :edit
    
    patch :update, id: @user, user: { password: "a"*6, password_confirmation: "b"*6 }
    assert_template :edit
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user, user: { username: @user.username, password: "blah" }
    end

    assert_redirected_to login_path
  end
end
