module Votable
  extend ActiveSupport::Concern

  included do
    before_create :set_votes_0
  end

  private

    def set_votes_0
      self.upvotes = 0
      self.downvotes = 0
    end
end
