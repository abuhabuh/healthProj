class UserSurgeonProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :surgeon_specialty

  validates_presence_of :user_id, :surgeon_specialty_id


  ###
  # Static methods
  ###

  # Returns surgeon profile object or Nil if not found
  def self.query_one_by_user_id(user_id)
    return UserSurgeonProfile.where(user_id: user_id).first
  end

end
