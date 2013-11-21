json.array!(@patients) do |patient|
  json.extract! patient, :medical_record_id, :last_name, :first_name, :middle_initial, :address1, :address2, :city, :state, :home_phone, :work_phone, :cell_phone, :date_of_birth, :gender, :race, :ethnicity, :preferred_language
  json.url patient_url(patient, format: :json)
end
