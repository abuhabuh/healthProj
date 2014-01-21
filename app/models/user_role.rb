class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  # Sets role names to match on in database
  # Access with UserRole::ROLE_SURGEON
  ROLE_ADMIN = 'Administrator'
  ROLE_SURGEON = 'Surgeon'
end
