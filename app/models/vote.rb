class Vote < ActiveRecord::Base

  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value,
            presence: true,
            inclusion: { in: [1, -1], message: "Vote must be 1 or -1" }
  validates :user, presence: true
  validates :user, uniqueness: { scope: :voteable }

  validate :check_against_self_voting

  def check_against_self_voting
    return unless voteable.respond_to?(:user) && voteable.user

    if voteable.user == user
      errors.add(:user, "cannot vote on their own content")
    end
  end
end
