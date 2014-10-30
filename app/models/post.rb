class Post < ActiveRecord::Base
  include Votable

  belongs_to :user, inverse_of: :posts
  has_many :comments, as: :parent

  has_many :votes, as: :votable
  has_many :voted_on_by, through: :votes, source: :user

  validates :title, presence: true, allow_blank: false
  validates :is_self_post, :inclusion => { :in => [true, false] }

  validates :self_text, presence: true, allow_nil: false, if: "is_self_post"
  validates :link, absence: true, if: "is_self_post"
  
  validates :self_text, absence: true, if: "not is_self_post"
  validates :link, presence: true, allow_nil: false, if: "not is_self_post"
end
