class User < ActiveRecord::Base
  self.per_page = 10
  
  before_create :create_remember_token

  has_secure_password
  validates :password, length: { maximum: 8, minimum: 6 }

  # before_validation { self.email = email.downcase; self.name = name.downcase }
  before_validation { email.downcase!; name.downcase! }
  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@([a-z\b\-]+.){1,}[a-z]+\z/i}, uniqueness: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
