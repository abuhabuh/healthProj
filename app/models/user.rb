class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Static class variables
  # TODO: make interaction with this more graceful? Reduce hard coding
  @@ROLES = %w(surgeon admin)

  # Validation
  validates_inclusion_of :role, :in => @@ROLES
  validates_presence_of :first_name, :last_name, :email, :encrypted_password,
                        :role

  # Static methods
  def self.get_available_roles
    return @@ROLES
  end

  # Instance methods
  def is_surgeon
    return role == @@ROLES[0]
  end

  def is_admin
    return role == @@ROLES[1]
  end
end
