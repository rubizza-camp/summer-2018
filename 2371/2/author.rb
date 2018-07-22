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

  def bad_words_per_battles
    bad_words.size.to_f / @battles.size
  end

  def words_per_battles_rounds
    @battles.map(&:words_per_round).inject(0, &:+)
  end

  def to_print
    [@name,
     "#{@battles.size} батлов",
     "#{bad_words.size} нецензурных слов",
     "#{format('%.2f', bad_words_per_battles)} слова на баттл",
     "#{words_per_battles_rounds} слова в раунде"]
  end
end
