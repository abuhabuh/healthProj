class PreopRiskAssessmentSerializer < ActiveModel::Serializer
  attributes :id, :bit_field, :height, :weight, :diabetes_mellitus, :functional_health_status, :sepsis_within_48hrs
  has_one :surgical_profile
end
