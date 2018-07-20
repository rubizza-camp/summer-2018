require_relative 'battle'

# Author responsible for author info
class Author
  attr_reader :name, :battles
  def initialize(author_name)
    @name = author_name
    @battles = []
  end

  def name?(name)
    @name.include?(name) || name.include?(@name)
  end

  def add_battle(battle)
    @battles << battle
  end

  def bad_words
    @battles.map(&:curse_words).flatten
  end

  def words_percent
    @battles.map(&:words_percent).inject(0, &:+)
  end

  def words_per_battle
    bad_words.size.to_f / @battles.size
  end

  def to_print
    [@name,
     "#{@battles.size} батлов",
     "#{bad_words.size} нецензурных слов",
     "#{format('%.2f', words_per_battle)} слова на баттл",
     "#{words_percent} слова в раунде"]
  end
end
