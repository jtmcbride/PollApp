# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  body    :text             not null
#  poll_id :integer          not null
#

class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    result = {}
    self.answer_choices.includes(:responses).each do |choice|
      result[choice.choice] = choice.responses.length
    end
    result
  end

  def responses_count
    result = {}
    responses = self.answer_choices
      .select('answer_choices.choice, COUNT(responses.id) AS count')
        .joins("LEFT OUTER JOIN responses ON responses.choice_id = answer_choices.id")
          .where("answer_choices.question_id = ?", self.id)
            .group('answer_choices.id')

    responses.each {|res| result[res.choice] = res.count}
    result
  end

end
