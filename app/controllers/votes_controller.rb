class VotesController < ApplicationController
  before_action :logged_in_user

  # Either creates a new vote, updates is_upvote, or deletes the vote
  def vote
    @user = User.find(params[:vote][:user_id])
    return false unless verify_user?

    if params[:vote][:votable_type] == "Post"
      votable = Post.find(params[:vote][:votable_id])
    elsif params[:vote][:votable_type] == "Comment"
      votable = Comment.find(params[:vote][:votable_id])
    end

    vote = Vote.where(user: @user, votable: votable).first_or_initialize
    # This seems a little redundant, but I want to avoid tricky unnoticed typecasting
    is_upvote = params[:vote][:is_upvote] == "true" ? true : false
    if is_upvote == vote.is_upvote
      vote.destroy
    else
      vote.is_upvote = is_upvote
      vote.save
    end

    votable.reload_votes

    render text: ""
  end

  private
    def verify_user?
      @user == current_user
    end
end
