require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "successful signup with remember me" do
    get new_user_path
    assert_template layout: 'layouts/no_sidebar'
    assert_template 'users/new'
    assert_difference 'User.count' do
      post_via_redirect users_path, user: { username: "newguy",
                                            email: nil,
                                            password: "heyopassword",
                                            password_confirmation: "heyopassword" },
                                    remember_me: "1"
    end
    assert is_logged_in?
    assert_not_nil cookies["remember_token"]
  end
  
  test "successful signup without remember me" do
    get new_user_path
    assert_template layout: 'layouts/no_sidebar'
    assert_template 'users/new'
    assert_difference 'User.count' do
      post_via_redirect users_path, user: { username: "newguy",
                                            email: nil,
                                            password: "heyopassword",
                                            password_confirmation: "heyopassword" },
                                    remember_me: "0"
    end
    assert is_logged_in?
    assert_nil cookies["remember_token"]
  end

  test "username must be unique on signup" do
    get new_user_path
    assert_template layout: 'layouts/no_sidebar'
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post_via_redirect users_path, user: { username: "newguy",
                                            email: nil,
                                            password: "heyapassword",
                                            password_confirmation: "heyopassword",
                                            remember_me: "0" }
    end
    assert_not is_logged_in?
    assert_template layout: 'layouts/no_sidebar'
    assert_template 'users/new'
  end
end
