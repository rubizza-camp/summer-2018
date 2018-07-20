module BattlerAsRow
  # This method smells of :reek:DuplicateMethodCall
  def self.get_battler_as_row(battler)
    row = []
    row += [battler.name.to_s]
    row += ["#{battler.number_of_battles} баттлов", "#{battler.number_of_bad_words} нецензурных слов"]
    row += ["#{battler.bad_words_per_round} слова на баттл", "#{battler.average_number_of_words} слов в раунде"]
    row
  end
end
