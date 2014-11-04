require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "successful signup" do
    get new_user_path
    assert_template layout: 'layouts/no_sidebar'
    assert_template 'users/new'

    assert_difference 'User.count' do
      post_via_redirect users_path, user: { username: "newguy",
                                            email: nil,
                                            password: "heyopassword",
                                            password_confirmation: "heyopassword",
                                            remember_me: "1" }
    end
  end

  test "username must be unique on signup" do
  end
end
