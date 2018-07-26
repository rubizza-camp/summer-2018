# rubocop:disable Style/MultilineBlockChain
# rubocop:disable Metrics/MethodLength
# :reek:TooManyStatements
class OutputTopBadWords
  def self.out
    BATTLERS_NAMES_LIST.map do |name|
      battler = Battler.new(name)
      battles_count = battler.battles_count
      words_in_battle = battler.words_in_battle
      words_in_raund = battler.words_in_raund
      count = BadWordsCounter.new(battler.all_battles_text).run
      { name:            name,
        bad_words_count: count,
        battles_count:   battles_count,
        words_in_raund:  words_in_raund,
        words_in_battle: words_in_battle }
    end.sort_by { |key| key[:bad_words_count] }.reverse
  end
end
# rubocop:enable Style/MultilineBlockChain
# rubocop:enable Metrics/MethodLength
