require 'active_support/concern'

module EncryptionKey
  extend ActiveSupport::Concern
  
  def encryption_key
    # if in production. require key to be set.
    if Rails.env.production?
      raise 'ENCRYPTOR_KEY environment variable not set' unless ENV['ENCRYPTOR_KEY']
      ENV['ENCRYPTOR_KEY']
    else
      puts '@@@ not production'
      if ENV['ENCRYPTOR_KEY']
        puts 'environment var found'
      else
        puts 'env var not found'
      end
      ENV['ENCRYPTOR_KEY'] ? ENV['ENCRYPTOR_KEY'] : 'blah_key'
    end
  end
 
end