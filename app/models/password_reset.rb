require 'securerandom'

class PasswordReset < ActiveRecord::Base
  attr_accessor :email

  belongs_to :user

  validates :user, presence :true

  before_validation :set_key
  before_validation :set_user

  after_create :send_email

  private

  def set_key
    self.key = SecureRandom.uuid
  end

  def set_user
    return unless email
    user = User.find_by(email: email) #because using attr_accessor above
  end

  def send_email
    SecurityMailer.password_reset(self).deliver
  end
end
