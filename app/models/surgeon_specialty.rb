class SurgeonSpecialty < ActiveRecord::Base
  has_many :user_surgeon_profiles

  validates_uniqueness_of :name
  validates_presence_of :name

  ###
  # Static methods
  ###

  def self.query_specialty_name(specialty_id)
    surgeon_specialty = SurgeonSpecialty.find(specialty_id)
    if not surgeon_specialty
      return ''
    end
    return surgeon_specialty.name
  end
end
