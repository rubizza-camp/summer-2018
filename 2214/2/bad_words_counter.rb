require 'russian_obscenity'

class BadWordsCounter
  BATTLES_FOLDER = 'Battles'.freeze
  def self.count(battles)
    bad_words = 0
    battles.each do |battle|
      bad_words += count_bad_words(Dir.chdir(BATTLES_FOLDER) { File.read(battle) })
    end
    bad_words
  end

  def self.count_bad_words(file)
    bad_words = 0
    file.split.each do |word|
      bad_words += 1 if RussianObscenity.obscene?(word)
    end
    bad_words += file.count('*')
    bad_words
  end
end
