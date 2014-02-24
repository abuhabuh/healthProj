class SurveyAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer_text, :answer_value
  has_one :survey_question
end
