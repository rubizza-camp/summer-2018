# The BattleEntity responsible for battle info
class BattleEntity
  def initialize(file_name)
    @curse_words = []
    @words_percent = 0
    manage_battle_text(File.read("./texts/#{file_name}"))
  end

  def manage_battle_text(text)
    @curse_words += text.scan(CURSE_WORDS_REGEX)
    rounds = text.scan(/Раунд\s?\d+?/i)
    @words_percent += format('%.2f', text.split(' ').size /
        (rounds.any? ? rounds.size : 1)).to_f
  end

  def data
    {
      curse_words: @curse_words.size,
      words_percent: @words_percent
    }
  end
end
