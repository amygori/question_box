class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_and_belongs_to_many :tags
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true
  validates :comments, presence: true
  validates :votes, presence: true

  scope :answered, -> { where("EXISTS (SELECT null FROM answers where answers.question_id = questions.id)") }
  scope :unanswered, -> { where("NOT EXISTS (SELECT null FROM answers where answers.question_id = questions.id)") }
  scope :recently_answered, -> do
    select("questions.*, MAX(answers.created_at) AS answered_at").
    joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id").
    group("questions.id").
    having("count(answers.id) > 0").
    order("answered_at DESC")
  end

  def answered?
    answers.count > 0
  end

  def unanswered?
    !answered?
  end

  def has_chosen_answer?
    answers.where(chosen: true).count > 0
  end

  def score
    votes.sum(:value)
  end
end
