class Ethnicity < ActiveRecord::Base

  include EncryptionKey

  # Encryption: encryption_key comes from encryption_key.rb concern
  attr_encrypted :name, :key => :encryption_key

end
