class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
  validates :username, length: { in: 3..30 }, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\S]+\z/ }
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_blank: true

  before_save { self.email.downcase! }

  has_many :posts, inverse_of: :user
  has_many :comments, inverse_of: :user

  has_many :votes
  has_many :voted_posts, through: :votes, foreign_key: "user_id", class_name: "Post",
           source_type: "Post", source: :votable
  has_many :voted_comments, through: :votes, foreign_key: "user_id", class_name: "Comment",
           source_type: "Comment", source: :votable

  before_destroy :clear_associates

  def to_param
    username
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

    # The associated objects should be reloaded into memory
    # It's not possible to reload them from this function...
    # Can't figure out why.
    def clear_associates
      self.posts.clear
      self.comments.clear
    end
end
