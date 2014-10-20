class Login
  include ActiveModel::Model

  attr_accessor :email, :password
  attr_reader :user
  validates :email, presence: true
  validates :password, presence: true
  validate :validate_authentication

  def initialize(attrs = {})
    super(attrs)
    @user = User.find_by(email: email)
  end

  def authenticated?
    user.authenticate(password) if user.present?
  end

  def validate_authentication
    errors.add(:password, "Email or password is invalid") unless authenticated?
  end
end
