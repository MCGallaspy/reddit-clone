require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "gosh@example.com", password: "hahaha", password_confirmation: "hahaha", username: "unique_user" }
    end

    assert_redirected_to user_path(assigns(:user))
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
    assert_redirected_to user_path(assigns(:user))
  end
  
  test "username should not be updatable" do
    patch :update, id: @user, user: { username: "blargle" }
    assert_redirected_to edit_user_path(@user)
  end
  
  test "invalid update data should redirect to user_edit_path" do
    patch :update, id: @user, user: { email: "bad@email" }
    assert_redirected_to edit_user_path(@user), message: "Invalid email was accepted for user update"
    
    patch :update, id: @user, user: { password: "a"*5 }
    assert_redirected_to edit_user_path(@user), message: "Invalid password accepted for user update"
    
    patch :update, id: @user, user: { password: "a"*6, password_confirmation: "b"*6 }
    assert_redirected_to edit_user_path(@user), message: "Password and password_confirmation should match for user update"
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
