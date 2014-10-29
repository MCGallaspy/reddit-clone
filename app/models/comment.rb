class Comment < ActiveRecord::Base
  belongs_to :parent, polymorphic: true
  belongs_to :user, inverse_of: :comments
  has_many :comments, as: :parent
end
