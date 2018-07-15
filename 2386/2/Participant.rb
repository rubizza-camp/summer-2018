# Class of Participant
class Participant
  attr_reader :name, :battles, :bad_words, :bad_in_round, :words_in_round

  def initialize(object)
    @name = object[:name]
    @battles = object[:battles]
    @bad_words = object[:bad_words]
    @bad_in_round = object[:bad_in_round]
    @words_in_round = object[:words_in_round]
  end
end
