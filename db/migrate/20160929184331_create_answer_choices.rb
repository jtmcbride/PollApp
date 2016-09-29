class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :choice, null: false
      t.integer :question_id, null: false
    end
  end
end
