class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user, presence: true
  validates :voteable, presence: true

  after_save :increase_user_score_by_10_for_voted_Q_or_A

  # is an up or down vote
  # if up vote, question or answer author gets 10 points added to score
  def increase_user_score_by_10_for_voted_Q_or_A
    if value == 1
    voteable.user.score += 10
    voteable.user.save
    end
  end
end
