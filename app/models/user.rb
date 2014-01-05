class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Static class variables
  # TODO: make interaction with this more graceful? Reduce hard coding
  # TODO: db stores as strings - normalize with other enum types implemented
  #   as integers in db?
  @@ROLES = %w(surgeon admin)

  ###
  # Validation
  ###
  validates_inclusion_of :role, :in => @@ROLES
  validates_presence_of :first_name, :last_name, :email, :encrypted_password,
                        :role

  ###
  # Static methods
  ###
  def self.get_available_roles
    return @@ROLES
  end

  def self.query_all_surgeons
    return User.where(role: @@ROLES[0])
  end

  # return nested arrays for surgeons and their ids for rails selector
  # - [['John Doe', 1], ['Jim Beam', 2]] -> text is mapped to index
  #   in the static constants array
  # TODO SCALING: this may become inefficient as # surgeons becomes large
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

  ###
  # Instance methods
  ###
  def is_surgeon
    return role == @@ROLES[0] # TODO: eliminate 0 hard coding?
  end

  def is_admin
    return role == @@ROLES[1]
  end

end
