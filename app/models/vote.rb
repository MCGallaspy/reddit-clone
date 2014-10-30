class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user, presence: true, on: :create
  validates :votable_id, uniqueness: { scope: [:user_id, :votable_type] }, on: :create
end
