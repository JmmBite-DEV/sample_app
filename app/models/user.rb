class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { maximum: 8, minimum: 6 }

  # before_validation { self.email = email.downcase; self.name = name.downcase }
  before_validation { email.downcase!; name.downcase! }
  validates :name, presence: true, length: { maximum: 16 }, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@([a-z\b\-]+.){1,}[a-z]+\z/i}, uniqueness: true
end
