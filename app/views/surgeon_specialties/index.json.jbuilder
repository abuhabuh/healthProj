json.array!(@surgeon_specialties) do |surgeon_specialty|
  json.extract! surgeon_specialty, :name
  json.url surgeon_specialty_url(surgeon_specialty, format: :json)
end
