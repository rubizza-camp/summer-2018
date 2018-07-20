# Search favorite words
class FavoriteWord < Word
  attr_reader :favorite_words
  def initialize(rap_files)
    super
    @favorite_words = Hash.new(0)
  end

  def fetch_favorite_words
    fetch_words
    favorite_words
  end

  def handling_text(text)
    counting_favorite_words(super)
    @favorite_words.select! { |_key, value| value > 2 }
  end

  private

  def counting_favorite_words(arr_words)
    arr_words.each { |word| @favorite_words[word] += 1 }
  end
end
