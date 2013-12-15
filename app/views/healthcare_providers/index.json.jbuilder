json.array!(@healthcare_providers) do |healthcare_provider|
  json.extract! healthcare_provider, :name, :type
  json.url healthcare_provider_url(healthcare_provider, format: :json)
end
