class Ethnicity < ActiveRecord::Base

  include EncryptionKey

  # Encryption: encryption_key comes from encryption_key.rb concern
  attr_encrypted :name, :key => :encryption_key

  ###
  # Static variables
  ###

  # Hash of database id to name
  @@ETHNICITIES = nil


  ###
  # Static methods
  ###

  def self.get_ethnicity_name(id)
    return @@ETHNICITIES[id]
  end

  def self.get_all_ethnicities_selector_array
    # Returns array of tuples [[:text, :id]..]
    # Ordered to work with rails html select box
    self.query_and_load_ethnicities()

    ethnicities_selector_arr = []

    @@ETHNICITIES.each do |key, value|
      ethnicities_selector_arr.push([value, key])
    end

    return ethnicities_selector_arr
  end



  private

    ###
    # Static methods
    ###

    def self.query_and_load_ethnicities
      if @@ETHNICITIES.nil?
        @@ETHNICITIES = Hash.new
        ethnicities = Ethnicity.all

        ethnicities.map do |ethnicity|
          @@ETHNICITIES[ethnicity.id] = ethnicity.name
        end
      end
    end





end
