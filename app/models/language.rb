class Language < ActiveRecord::Base

  include EncryptionKey

  # Encryption
  attr_encrypted :name, :key => :encryption_key

end
