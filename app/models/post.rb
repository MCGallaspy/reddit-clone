class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :children, as: :parent
end
