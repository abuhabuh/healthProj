json.array!(@races) do |race|
  json.extract! race, :name
  json.url race_url(race, format: :json)
end
