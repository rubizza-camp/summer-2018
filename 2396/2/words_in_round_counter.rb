# This is class WordsInRoundCounter
class WordsInRoundCounter
  include Helper
  def initialize(battles, raper_name, count_battles)
    @battles = battles
    @raper_name = raper_name
    @count_battles = count_battles
  end

  def count
    count_words / (@count_battles * count_rounds)
  end

  private

  def count_words
    text = @battles.map(&:text).join(' ')
    Helper.clearing_text_from_garbage(text).size
  end

  def count_rounds
    tmp_count = @battles.map(&:text).join(' ').split(/Раунд\s[0-9]\./).size
    tmp_count.zero? ? 1 : tmp_count
  end
end
