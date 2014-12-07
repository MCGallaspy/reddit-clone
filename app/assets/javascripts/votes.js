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
    if ( upvote_button.hasClass("upvoted") ) {
      upvote_button.removeClass("upvoted").addClass("unvoted");
      after_upvote.css("display", "none");
      before_vote.css("display", "block");

    } else {
      upvote_button.removeClass("unvoted").addClass("upvoted");
      after_upvote.css("display", "block");
      before_vote.css("display", "none");
    }
    downvote_button.removeClass("downvoted").addClass("unvoted");
    after_downvote.css("display", "none");
  } else {
    if ( downvote_button.hasClass("downvoted") ) {
      downvote_button.removeClass("downvoted").addClass("unvoted");
      after_downvote.css("display", "none");
      before_vote.css("display", "block");

    } else {
      downvote_button.removeClass("unvoted").addClass("downvoted");
      after_downvote.css("display", "block");
      before_vote.css("display", "none");
    }
    upvote_button.removeClass("upvoted").addClass("unvoted");
    after_upvote.css("display", "none");
  }
};
