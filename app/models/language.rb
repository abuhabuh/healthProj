class Language < ActiveRecord::Base

  include EncryptionKey

  # Encryption
  attr_encrypted :name, :key => :encryption_key

  ###
  # Static variables
  ###

  # Hash of database id to name
  @@LANGUAGES = nil


  ###
  # Static methods
  ###

  def self.get_language_name(id)
    return @@LANGUAGES[id]
  end

  def self.get_all_languages_selector_array
    # Returns array of tuples [[:text, :id]..]
    # Ordered to work with rails html select box
    self.query_and_load_languages()

    languages_selector_arr = []

    @@LANGUAGES.each do |key, value|
      languages_selector_arr.push([value, key])
    end

    return languages_selector_arr
  end



  private

    ###
    # Static methods
    ###

    def self.query_and_load_languages
      if @@LANGUAGES.nil?
        @@LANGUAGES = Hash.new
        languages = Language.all

        languages.map do |language|
          @@LANGUAGES[language.id] = language.name
        end
      end
    end




end
