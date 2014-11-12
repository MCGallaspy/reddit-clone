function vote(vote_url, is_upvote, votable_type, votable_id, user_id) {
  params = { vote: { "is_upvote": is_upvote,
                     "votable_type": votable_type,
                     "votable_id": votable_id,
                     "user_id": user_id
           }};
  $.post(vote_url, params);
};
