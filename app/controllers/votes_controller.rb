class VotesController < ApplicationController
  before_action :logged_in_user

  def new_or_create
    @user = User.find(params[:vote][:user_id])
    return false unless verify_user?

    if params[:vote][:votable_type] == "Post"
      votable = Post.find(params[:vote][:votable_id])
    elsif params[:vote][:votable_type] == "Comment"
      votable = Comment.find(params[:vote][:votable_id])
    end

    vote = Vote.where(user: @user, votable: votable).first_or_initialize
    vote.is_upvote = params[:vote][:is_upvote]
    vote.save

    votable.reload_votes

    render text: ""
  end

  def destroy
  end

  private
    def verify_user?
      @user == current_user
    end
end
