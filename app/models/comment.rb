class Comment < ActiveRecord::Base
  include Votable

  belongs_to :parent, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comments, as: :parent

  has_many :votes, as: :votable
  has_many :voted_on_by, through: :votes, source: :user
  
  validates :parent, presence: true, allow_nil: false
  validates :content, presence: true, allow_blank: false
end
