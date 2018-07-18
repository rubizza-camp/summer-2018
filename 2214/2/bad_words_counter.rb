require 'russian_obscenity'
require_relative 'battle'

class BadWordsCounter
  def self.count(battles, battler_name)
    bad_words = 0
    battles.each do |battle|
      bad_words += count_bad_words(battle.text) if battle.title.split('против').first.include? battler_name
    end
    bad_words
  end

  def self.count_bad_words(file)
    bad_words = 0
    file.split.each do |word|
      bad_words += 1 if RussianObscenity.obscene?(word) || word.include?('*')
    end
    bad_words
  end
end
