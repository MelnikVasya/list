class User < ActiveRecord::Base
  has_many :task_lists, dependent: :destroy
  has_many :tasks
  VALID_NAME_REGEX = /\A[a-zA-Z0-9_]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*\z/
  before_save { email.downcase! }
  before_create :create_remember_token
  validates :name, presence: true, format: { with: VALID_NAME_REGEX },
            length: { minimum: 3, maximum: 15 }, uniqueness: true

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, format: { with: VALID_PASSWORD_REGEX },
            length: { minimum: 6, maximum: 255 }
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
