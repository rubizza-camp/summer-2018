require 'russian_obscenity'
require_relative 'rap_battle'

# Counts obscene words
class BadWordsCounter
  def self.count(battles, battler_name)
    files = battles_of_battler(battles, battler_name).map(&:text).join(' ')
    count_bad_words(files)
  end

  def self.count_bad_words(file)
    file.split.select { |word| word.include?('*') || RussianObscenity.obscene?(word) }.count
  end

  def self.battles_of_battler(battles, battler_name)
    battles.select { |battle| battle.title.split('против').first.include? battler_name }
  end
end
