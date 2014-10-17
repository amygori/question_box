class Vote < ActiveRecord::Base





  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value,
            presence: true,
            inclusion: { in: [1, -1], message: "Vote must be 1 or -1" }
  validates :user, presence: true

  validate :check_against_self_voting

  before_save :adjust_points

  def check_against_self_voting
    return unless voteable.respond_to?(:user) && voteable.user

    if voteable.user == user
      errors.add(:user, "cannot vote on their own content")
    end
  end

  def adjust_points
    if value > 0
      voteable.user.increment!(:score, 10)
    elsif value < 0
      if voteable.user.score >= 5
        voteable.user.decrement!(:score, 5)
      else
        voteable.user.update_attribute(:score, 0)
      end

      user.decrement!(:score)
    end

    voteable.user.save
  end

end
