class Comment < ActiveRecord::Base
  include Votable

  belongs_to :parent, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comments, as: :parent
  
  validates :parent, presence: true, allow_nil: false
  validates :content, presence: true, allow_blank: false
end
