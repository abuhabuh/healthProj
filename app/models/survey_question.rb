class SurveyQuestion < ActiveRecord::Base

  after_initialize :setup

  # Static class variables

  # IMPORTANT: do not change order of array constants, only append;
  # values tied to database entries indexed according to order
  @@IS_ACTIVE_VALUES = ['false', 'true']

  # Function to setup default values for class instance variables
  # initialize() may not always be called when creating obj from
  # active record
  def setup
    puts 'initialize for SurveyQuestion called'
    @answers = []
  end

  ###
  # Static methods
  ###

  def self.get_is_active_values
    return @@IS_ACTIVE_VALUES
  end

  # return static constant nested arrays for selector that includes
  #   select option value and text
  # - [[false, 0], [true, 1] -> text is mapped to index
  #   in the static constants array
  def self.get_is_active_values_select
    return self.get_is_active_values.map.with_index{|x,i| [x,i]}
  end


  ###
  # Instance methods
  ###

  def add_answer(answer)
    @answers.push(answer)
  end

  def get_answers()
    if @answers.nil?
      puts "@@@@@ fuck...get_answers nil in SurveyQuestion"
    end

    return @answers
  end

end
