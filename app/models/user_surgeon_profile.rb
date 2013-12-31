class UserSurgeonProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :surgeon_specialty

  validates_presence_of :user_id, :surgeon_specialty_id
end
