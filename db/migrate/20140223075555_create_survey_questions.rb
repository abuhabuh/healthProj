class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.string :question_text
      t.integer :is_active

      t.timestamps
    end
  end
end
