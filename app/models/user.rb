class User < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[\w\-\.]+@[\w\-\.]+\Z/, message: "must be a valid email address" }

  validates :name, presence: true
  validates :comments, presence: true
  validates :votes, presence: true

  validates :score,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_secure_password
end
