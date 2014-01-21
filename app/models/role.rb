class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles

  ###
  # Static variables
  ###

  ###
  # Static methods
  ###
  def self.query_all_roles_selector_array
    # Returns array of tuples [[:name, :id]..]
    # Ordered to work with rails html select box
    return Role.pluck(:name, :id)
  end

end