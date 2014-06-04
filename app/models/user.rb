class User < ActiveRecord::Base

  attr_reader :password

  before_validation :ensure_session_token
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :circles, inverse_of: :user
  has_many :circle_memberships, foreign_key: :member_id, inverse_of: :member
  
  has_many :posts, inverse_of: :author
  has_many :cliques, through: :circle_memberships, source: :member
  has_many :incoming_posts, through: :cliques, source: :posts

  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end
  
  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)
    
    if @user.is_password?(password)
      @user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end  
  
  private
  
  def ensure_session_token
    self.session_token ||= User.generate_token
  end
end
