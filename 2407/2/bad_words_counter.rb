require 'russian_obscenity'
require_relative 'battle.rb'

# Counts obscene words
class BadWordsCounter
  def self.count(battles, battler_name)
    files = battles_of_battler(battles, battler_name).map(&:text).join(' ')
    count_bad_words(files)
  end

  def self.count_bad_words(file)
    local_bad_words = 0
    file.split.each do |word|
      local_bad_words += 1 if RussianObscenity.obscene?(word)
    end
    local_bad_words += file.count('*')
    local_bad_words
  end

  def self.battles_of_battler(battles, battler_name)
    battles.select { |battle| battle.title.split('против').first.include? battler_name }
  end
end
