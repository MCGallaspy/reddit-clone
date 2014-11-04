require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = users(:mike)
  end

  test "valid users should be valid" do
    assert @user.valid?, "Valid test data was not recognized as valid."
  end

  test "username is at least 3 characters" do
    @user.username = "g"
    assert_not @user.valid?, "Username must be at least 3 characters long."
  end
  
  test "username is at most 30 characters" do
    @user.username = "g"*31
    assert_not @user.valid?, "Username must be at most 30 characters long."
  end

  test "username is present" do
    @user.username = "     "
    assert_not @user.valid?, "Username must be present"
  end

  test "username must be unique and case insensitive" do
    userdup = @user.dup
    userdup.username.upcase!
    userdup.email = "somethingelse@boo.net"
    assert_not userdup.valid?, "Username should be unique and case insensitive"
  end

  test "username should be valid (no whitespace)" do
    @user.username = "this is not a valid username\n\n"
    assert_not @user.valid?, "Username should not contain whitespace"
  end

  test "email should be valid" do
    invalid_emails = %w[johnatblah.com harry@eagles user..@blank.com username@example. something@foo_bar.ship blah@blank+dog.net]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should not be a valid email"
    end
  end

  test "email must be unique and case insensitive" do
    userdup = @user.dup
    userdup.email.upcase!
    userdup.username = "heyyo"
    assert_not userdup.valid?, "Email should be unique and case insensitive"
  end

  test "password should have a minimum length of 6" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?, "Password must have a minimum length of 6"
  end

  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?('')
  end
end
