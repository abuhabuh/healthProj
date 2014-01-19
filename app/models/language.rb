class Language < ActiveRecord::Base
  # Encryption
  attr_encrypted :name, :key => 'blah_key'


end
