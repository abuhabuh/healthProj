json.array!(@user_surgeon_profiles) do |user_surgeon_profile|
  json.extract! user_surgeon_profile, :belongs_to, :belongs_to
  json.url user_surgeon_profile_url(user_surgeon_profile, format: :json)
end
