# == Schema Information
#
# Table name: responses
#
#  id        :integer          not null, primary key
#  user_id   :integer          not null
#  choice_id :integer          not null
#

class Response < ActiveRecord::Base
  validates :user_id, :choice_id, presence: true
  validate :not_duplicate_response, :respondent_is_author

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def respondent_is_author
    if self.user_id == self.question.poll.author_id
      self.errors['author'] << "you're the author of this poll"
    end
  end

  def sibling_responses
    question = self.question
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      self.errors["duplicates"] << "Already answered!!"
    end
  end
end
