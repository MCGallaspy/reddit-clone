function vote(vote_url, is_upvote, votable_type, votable_id, user_id, caller) {
  // Fire off the http stuff
  params = { vote: { "is_upvote": is_upvote,
                     "votable_type": votable_type,
                     "votable_id": votable_id,
                     "user_id": user_id
           }};
  $.post(vote_url, params);
  // Update stuff on the client side
  upvote_button =  $(caller).parent().parent().children(".upvote-button").children("div");
  downvote_button =  $(caller).parent().parent().children(".downvote-button").children("div");
  before_vote =  $(caller).parent().parent().children(".before-vote");
  after_upvote =  $(caller).parent().parent().children(".after-upvote");
  after_downvote =  $(caller).parent().parent().children(".after-downvote");
  if (is_upvote == true) {
    upvote_button.removeClass("unvoted").addClass("upvoted");
    downvote_button.removeClass("downvoted").addClass("unvoted");
    after_upvote.css("display", "block");
    after_downvote.css("display", "none");
    before_vote.css("display", "none");
  } else {
    upvote_button.removeClass("upvoted").addClass("unvoted");
    downvote_button.removeClass("unvoted").addClass("downvoted");
    after_downvote.css("display", "block");
    after_upvote.css("display", "none");
    before_vote.css("display", "none");
  }
};
