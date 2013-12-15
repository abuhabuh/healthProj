json.array!(@health_care_providers) do |health_care_provider|
  json.extract! health_care_provider, :name, :type
  json.url health_care_provider_url(health_care_provider, format: :json)
end
