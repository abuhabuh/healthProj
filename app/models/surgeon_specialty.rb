class SurgeonSpecialty < ActiveRecord::Base
  has_many :user_surgeon_profiles

  validates_uniqueness_of :name
  validates_presence_of :name
end
