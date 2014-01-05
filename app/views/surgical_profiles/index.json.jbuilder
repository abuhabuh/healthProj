json.array!(@surgical_profiles) do |surgical_profile|
  json.extract! surgical_profile, :user_id, :patient_id, :patient_status, :elective_surgery, :principal_procedure, :cpt_code, :origin_status, :hospital_admission_date, :operation_date, :anesthesia_technique, :encounter_number
  json.url surgical_profile_url(surgical_profile, format: :json)
end
