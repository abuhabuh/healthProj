json.array!(@preop_risk_assessments) do |preop_risk_assessment|
  json.extract! preop_risk_assessment, :surgical_profile_id, :bit_field, :height, :weight, :diabetes_mellitus, :functional_health_status, :sepsis_within_48hrs
  json.url preop_risk_assessment_url(preop_risk_assessment, format: :json)
end
