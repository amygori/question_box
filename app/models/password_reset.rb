require 'securerandom'

class PasswordReset < ActiveRecord::Base
  attr_accessor :email

  belongs_to :user

  validates :user, presence: true
  validates :email,
            presence: true,
            format: { with: /\A[\w\-\.]+@[\w\-\.]+\Z/, message: "must be a valid email address" }

  before_validation :set_key
  before_validation :set_user

  after_create :send_email

  private

  def set_key
    self.key = SecureRandom.uuid
  end

  def set_user
    return unless email
    self.user = User.find_by(email: email)
  end

  def send_email
    SecurityMailer.password_reset(user, key).deliver
  end
end
