class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true
  validates :comments, presence: true
  validates :votes, presence: true

  def has_chosen_answer?
    answers.where(chosen: true).count > 0
  end
end
