class Race < ActiveRecord::Base

  include EncryptionKey

  has_many :patients

  # Encryption
  attr_encrypted :name, :key => :encryption_key

  ###
  # Static variables
  ###

  # Hash of database id to name
  @@RACES = nil


  ###
  # Static methods
  ###

  def self.get_race_name(id)
    return @@RACES[id]
  end

  def self.get_all_races_selector_array
    # Returns array of tuples [[:text, :id]..]
    # Ordered to work with rails html select box
    self.query_and_load_races()

    races_selector_arr = []

    @@RACES.each do |key, value|
      races_selector_arr.push([value, key])
    end

    return races_selector_arr
  end



  private

    ###
    # Static methods
    ###

    def self.query_and_load_races
      if @@RACES.nil?
        @@RACES = Hash.new
        races = Race.all

        races.map do |race|
          @@RACES[race.id] = race.name
        end
      end
    end



end
