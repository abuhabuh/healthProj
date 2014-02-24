class CreateSurveyAnswers < ActiveRecord::Migration
  def change
    create_table :survey_answers do |t|
      t.string :answer_text
      t.integer :answer_value
      t.belongs_to :survey_question, index: true

      t.timestamps
    end

    add_foreign_key(:survey_answers, :survey_questions)
  end
end
