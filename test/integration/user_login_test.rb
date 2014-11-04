require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test "login with invalid information" do
    get root_path
    assert_template 'layouts/application'
    post login_path, session: { username: "    ", password: " " }
    assert_template 'layouts/application'
    assert_not flash.empty?, "Invalid credentials should give error"
    get root_path
    assert flash.empty?
  end

  test "login with valid credentials followed by logout" do
    get root_path
    assert_template 'layouts/application'
    post login_path, session: { username: @user.username, password: "MyString" }
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'layouts/application'
    assert_select "form[action=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # Now logout
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "form[action=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, password: 'MyString', remember_me: '1')
    assert is_logged_in?
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, password: 'MyString', remember_me: '0')
    assert is_logged_in?
    assert_nil cookies['remember_token']
  end
end
