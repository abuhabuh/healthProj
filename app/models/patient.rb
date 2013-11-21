class Patient < ActiveRecord::Base

  # Static class variables
  @@enum_sex = %w(male female)



  # Validation
  validates_inclusion_of :gender, :in => @@enum_sex

end
