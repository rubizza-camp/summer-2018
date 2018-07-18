# :reek:TooManyInstanceVariables
# Class of Participant
class Participant
  attr_reader :name, :battles, :bad_words, :bad_in_round, :words_in_round

  def initialize(name:, battles:, bad_words:, bad_in_round:, words_in_round:)
    @name = name
    @battles = battles
    @bad_words = bad_words
    @bad_in_round = bad_in_round
    @words_in_round = words_in_round
  end
end
