require_relative 'RapersCounters'

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
