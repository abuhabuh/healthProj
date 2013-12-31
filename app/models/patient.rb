class Patient < ActiveRecord::Base

  # Static class variables
  @@ENUM_SEX = %w(male female)

  # Validation
  validates_inclusion_of :gender, :in => @@ENUM_SEX
  validates_uniqueness_of :medical_record_id
end
