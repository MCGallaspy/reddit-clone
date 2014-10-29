require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:ricky)
    @link_post = posts(:link_post)
    @self_post = posts(:self_post)
  end

  test "upvotes and downvotes should be 0 on creation" do
    post = Post.create(user: @user,
                       title: "A title",
                       is_self_post: false,
                       link: "http://www.google.com")
    assert post.upvotes == 0, "upvotes not equal to 0 on creation."
    assert post.downvotes == 0, "downvotes not equal to 0 on creation."
  end

  test "post must have title" do
    @link_post.title = "     "
    assert_not @link_post.valid?
  end

  test "post user may be nil if user is destroyed" do
    @link_post.user.destroy
    assert @link_post.user.nil?, "Post user not nil after user is #{@link_post.user.inspect}"
  end

  test "self_text should be nil if not is_self_post" do
    assert_not @link_post.is_self_post, "Link post should have is_self_post == false"
    assert @link_post.self_text.nil?, "Link post self_text should be nil"
  end
  
  test "link should be nil if is_self_post" do
    assert @self_post.is_self_post, "Self post should have is_self_post == true"
    assert_not @self_post.self_text.nil?, "Self post self_text should not be nil"
  end

  test "is_self_post must not be nil (true or false only)" do
    assert_not @link_post.is_self_post.nil?
    assert_not @self_post.is_self_post.nil?
  end
end
