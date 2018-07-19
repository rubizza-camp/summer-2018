# Class for Battle
class Battle
  def initialize(file_name)
    @file_name = file_name
  end

  def count_bad_words
    fetch_words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def words_count
    fetch_words.count
  end

  def count_all_words
    fetch_words.count
  end

  def rounds_count
    rounds_number = fetch_text.scan(/Раунд \d/).length
    rounds_number.equal?(0) ? 1 : rounds_number
  end

  private

  def fetch_text
    @fetch_text ||= File.read(@file_name)
  end

  def fetch_words
    @all_words = fetch_text.scan(/[а-яА-ЯёЁ*]+/)
  end
end
