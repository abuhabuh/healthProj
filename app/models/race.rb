class Race < ActiveRecord::Base
  has_many :patients

  # Encryption
  attr_encrypted :name, :key => 'blah_key'

end
