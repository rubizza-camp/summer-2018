require_relative 'rapers_counters'

# The class Raper is responsible for models of rapers wich a saved and processed later
# This method smells of :reek:TooManyInstanceVariables
# Disable reek on this class becouse on my opinion in that example are not many variables
class Raper
  extend RapersCounters

  attr_reader :name, :battles, :bad_words, :bad_in_round, :words_in_round
  def add_raper(raper)
    titles_of_the_current_raper = find_rapers_titles(raper)
    Raper.new(moduling_hash(raper, titles_of_the_current_raper))
  end

  def initialize(option)
    @name = option[:name]
    @battles = option[:battles]
    @bad_words = option[:bad_words]
    @bad_in_round = option[:bad_in_round]
    @words_in_round = option[:words_in_round]
  end
end
