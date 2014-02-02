class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ###
  # Validation
  ###
  validates_presence_of :first_name, :last_name, :email, :encrypted_password

  ###
  # Static methods
  ###

  # Return all users who are surgeons
  # TODO: paginate this? but this needs to be in surgical profile dropdown
  # TEST - http://localhost:3000/patients/17/surgical_profiles/new
  def self.query_all_surgeons
    return User.joins(user_roles: :role)
               .where(roles: {name: UserRole::ROLE_SURGEON})
  end

  def self.query_one_surgeon_by_id(surgeon_id)
    return User.find(surgeon_id)
  end

  # return nested arrays for surgeons and their ids for rails selector
  # - [['John Doe', 1], ['Jim Beam', 2]] -> text is mapped to index
  #   in the static constants array
  # TODO SCALING: this may become inefficient as # surgeons becomes large
  # TEST - http://localhost:3000/patients/17/surgical_profiles/new
  def self.query_surgeons_selector_array
    surgeons = self.query_all_surgeons
    surgeons_selector_arr = []

    surgeons.map do |surgeon|
      surgeons_selector_arr.push(
        [surgeon.first_name + ' ' + surgeon.last_name, surgeon.id]
      )
    end

    return surgeons_selector_arr
  end

  def self.query_all_users_selector_array
    users = User.pluck(:first_name, :last_name, :middle_initial, :id)
    return users.map {|first, last, middle, id| [first.to_s + ' ' + middle.to_s + ' ' + last.to_s, id]}
  end

  ###
  # Instance methods
  ###

  def query_roles
    return self.roles
  end

  def is_surgeon
    return self._has_role UserRole::ROLE_SURGEON
  end

  def is_admin
    return self._has_role UserRole::ROLE_ADMIN
  end

  ###
  # Private methods
  ###

  def _has_role(role_string)
    self.roles.each do |role|
      if role.name == role_string
        return true
      end
    end
    return false
  end

end
