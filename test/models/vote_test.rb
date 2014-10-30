require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
    @post = posts(:self_post)
  end

  test "vote user should not be nil on creation" do
    vote = Vote.new(user: nil, votable: @post)
    assert_not vote.save, "Vote user should not be nil on creation"
  end

  test "vote user should be nil if user is deleted" do
    vote = Vote.create(user: @user, votable: @post)
    @user.destroy
    vote.reload
    assert vote.user == nil, "vote.user should be nil if user is deleted. It was: #{vote.user.inspect}"
  end

  test "vote user and votable should be unique on creation" do
    vote1 = Vote.create(user: @user, votable: @post)
    vote2 = Vote.new(user: @user, votable: @post)
    assert_not vote2.save, "Vote user and votable should be collectively unique"
  end
end
