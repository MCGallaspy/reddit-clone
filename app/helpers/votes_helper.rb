module VotesHelper
  # Look in app/javascript/vote.js for the relevant vote function here
  def upvote_link(votable)
    return link_to '/\\', login_path if current_user.nil?
    votable_type = votable.class.name
    raw "<div onclick=\"vote('#{vote_path}', true, '#{votable_type}', #{votable.id}, #{current_user.id})\">/\\</div>"
  end

  def downvote_link(votable)
    return link_to '\\/', login_path if current_user.nil?
    votable_type = votable.class.name
    raw "<div onclick=\"vote('#{vote_path}', false, '#{votable_type}', #{votable.id}, #{current_user.id})\">\\/</div>"
  end
end
