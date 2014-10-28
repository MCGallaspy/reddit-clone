class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
  validates :username, length: { in: 3..30 }, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\S]+\z/ }
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true
  
  validates :password, :allow_blank, on: :update
  before_save { self.email.downcase! }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MINCOST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
