# Class for Artist - Battle belongs_to Artist?:)
class Artist
  attr_reader :battler_name
  def initialize(battler_name)
    @battler_name = battler_name
    @battlers_array = []
  end

  def add_battles(file_name)
    @battlers_array << Battle.new(file_name)
  end

  def create_table_row
    [
      @battler_name,
      "#{battles_number} батлов",
      "#{count_bad_words} нецензурных слов",
      "#{bad_words_in_battle.round(2)} слов на батл",
      "#{words_in_round.round(2)} слов в рануде"
    ]
  end

  def count_bad_words
    @count_bad_words ||= @battlers_array.sum(&:count_bad_words)
  end

  private

  def bad_words_in_battle
    (count_bad_words.to_f / battles_number != 0 ? battles_number : 1)
  end

  def words_count
    @battlers_array.sum(&:words_count)
  end

  def rounds_count
    @battlers_array.sum(&:rounds_count)
  end

  def battles_number
    @battlers_array.size
  end

  def words_in_round
    (words_count / rounds_count.to_f).to_f
  end
end
