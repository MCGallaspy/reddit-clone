module Votable
  extend ActiveSupport::Concern

  included do
    before_create :set_votes_0
  end

  def reload_votes
    self.upvotes = self.votes.where(is_upvote: true).count
    self.downvotes = self.votes.where(is_upvote: false).count
    self.save
  end

  private

    def set_votes_0
      self.upvotes = 0
      self.downvotes = 0
    end
end
