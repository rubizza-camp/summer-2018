require_relative 'rapers_counters'
require_relative 'counters'

# The class Raper is responsible for models of rapers wich a saved and processed later
# This method smells of :reek:TooManyInstanceVariables
# Disable reek on this class becouse on my opinion in that example are not many variables

class Raper
  extend RapersCounters
  extend Counters

  attr_reader :name, :battles, :bad_words, :bad_in_round, :words_in_round

  def initialize(option)
    @name = option[:name]
    @battles = option[:battles]
    @bad_words = option[:bad_words]
    @bad_in_round = option[:bad_in_round]
    @words_in_round = option[:words_in_round]
  end
end
