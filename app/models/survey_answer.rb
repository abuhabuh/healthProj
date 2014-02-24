class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey_question


  ###
  # Static methods
  ###

  def self.query_all_answers_order_by_question
    return SurveyAnswer.order(:survey_question_id).all
  end


end
