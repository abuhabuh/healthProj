json.array!(@ethnicities) do |ethnicity|
  json.extract! ethnicity, :name
  json.url ethnicity_url(ethnicity, format: :json)
end
