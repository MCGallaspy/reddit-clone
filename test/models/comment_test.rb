require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = users(:mike)
    @post = posts(:link_post)
    @comment = Comment.new(content: "A comment")
    @comment.user = @user
    @comment.parent = @post
    @comment.save
  end

  test "comment should be valid" do
    assert comments(:one).valid?, "Valid comment not recognized as valid"
  end

  test "upvotes and downvotes should be 0 on creation" do
    assert @comment.upvotes == 0, "upvotes not equal to 0 on creation."
    assert @comment.downvotes == 0, "downvotes not equal to 0 on creation."
  end

  test "comment parent must not be nil" do
    @comment.parent = nil
    assert_not @comment.valid?, "comment parent must not be nil"
  end

  test "comment user should be nil if user is destroyed" do
    @user.destroy
    assert @comment.user.nil?, "comment user isn't nil, it's: #{@comment.user.inspect}"
  end

  test "comment content should not be blank" do
    @comment.content = " "
    assert_not @comment.valid?
  end
end
