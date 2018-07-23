# Class of Participant
class Participant
  attr_reader :name, :battles, :words

  def initialize(name:, battles:, bad_words:, bad_in_round:, words_in_round:)
    @name = name
    @battles = battles
    @words = [bad_words, bad_in_round, words_in_round]
  end

  # :reek:DuplicateMethodCall { max_calls: 3 } How can this be corrected at all?
  def self.get_participant_row(participant)
    [
      participant.name,
      "#{participant.battles.size} батлов",
      "#{participant.words[0]} нецензурных слов",
      "#{participant.words[1].round(2)} слов на батл",
      "#{participant.words[2]} слов в раунде"
    ]
  end
end
