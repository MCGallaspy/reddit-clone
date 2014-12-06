module VotesHelper
  # Look in app/javascript/vote.js for the relevant vote function here
  def upvote_link(votable)
    return link_to '/\\', login_path if current_user.nil?
    votable_type = votable.class.name
    # Does the vote already exist?
    vote = Vote.find_by_votable_type_and_votable_id_and_user_id(votable_type, votable.id, current_user.id)
    upvoted = vote.is_upvote unless vote.nil?
    css_class = upvoted ? "upvoted" : "unvoted"
    raw "<div class=\"#{css_class}\" onclick=\"vote('#{vote_path}', true, '#{votable_type}', #{votable.id}, #{current_user.id}, this)\">/\\</div>"
  end

  def downvote_link(votable)
    return link_to '\\/', login_path if current_user.nil?
    votable_type = votable.class.name
    # Does the vote already exist?
    vote = Vote.find_by_votable_type_and_votable_id_and_user_id(votable_type, votable.id, current_user.id)
    downvoted = (not vote.is_upvote) unless vote.nil?
    css_class = downvoted ? "downvoted" : "unvoted"
    raw "<div class=\"#{css_class}\" onclick=\"vote('#{vote_path}', false, '#{votable_type}', #{votable.id}, #{current_user.id}, this)\">\\/</div>"
  end

  def vote_count(votable)
    votable_type = votable.class.name
    vote = Vote.find_by_votable_type_and_votable_id_and_user_id(votable_type, votable.id, current_user.id)
    
    before_vote_disp = "none"
    after_upvote_disp = "none"
    after_downvote_disp = "none"
    if vote.nil?
      before_vote_disp = "block"
    elsif vote.is_upvote
      after_upvote_disp = "block"
    else
      after_downvote_disp = "block"
    end 
    
    raw "<div style=\"display: #{before_vote_disp};\" class=\"votes before-vote\">#{votable.upvotes - votable.downvotes}</div>
         <div style=\"display: #{after_upvote_disp};\" class=\"votes after-upvote\">#{votable.upvotes - votable.downvotes + 1}</div>
         <div style=\"display: #{after_downvote_disp};\" class=\"votes after-downvote\">#{votable.upvotes - votable.downvotes - 1}</div>"
  end
end
