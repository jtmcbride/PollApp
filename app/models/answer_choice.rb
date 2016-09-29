# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  choice      :text             not null
#  question_id :integer          not null
#

class AnswerChoice < ActiveRecord::Base
  validates :choice, :question_id, presence: true

  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :choice_id,
    primary_key: :id
  )

end
