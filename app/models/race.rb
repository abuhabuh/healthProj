class Race < ActiveRecord::Base

  include EncryptionKey

  has_many :patients

  # Encryption
  attr_encrypted :name, :key => :encryption_key

end
