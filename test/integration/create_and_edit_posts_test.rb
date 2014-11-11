require 'test_helper'

class CreateAndEditPostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    log_in_as @user, password: "MyString"
  end

  test "create new self post" do
    get new_post_path, post_type: :self_post
    assert_select "form[id=?]", :self_post_form 
    assert_select "form[id=?]", :link_post_form, count: 0
    assert_difference 'Post.count' do
      post posts_path, post: { title: "test title",
                               self_text: "A test post.",
                               user_id: @user.id,
                               link: nil,
                               is_self_post: true }
    end
    @post = Post.order('created_at').last
    assert_redirected_to post_path @post
  end

  test "create new link post" do
    get new_post_path, post_type: :link_post
    assert_select "form[id=?]", :link_post_form
    assert_select "form[id=?]", :self_post_form, count: 0
    assert_difference 'Post.count' do
      post posts_path, post: { title: "test title",
                               self_text: nil,
                               user_id: @user.id,
                               link: "http://www.google.com",
                               is_self_post: false }
    end
    @post = Post.order('created_at').last
    assert_redirected_to post_path @post
  end

  # I don't want to stipulate too much how the posts should look at this point
  # Hence the silly short test
  test "displays index page of posts" do
    get posts_path
    assert_select "div[class=?]", "posts", count: 1
  end
end
