require 'russian_obscenity'

module Counters
  PATH_FOLDER = 'texts'.freeze
  def count_normal(battles)
    words = 0
    battles.each do |battle|
      words += Dir.chdir(PATH_FOLDER) { File.read(battle) }
                  .gsub(/[.!-?,:]/, ' ').strip.split.count
    end
    words / (battles.size * 3)
  end

  def count_bad(battles)
    bad_words = 0
    battles.each do |battle|
      bad_words += count_bad_words(Dir.chdir(PATH_FOLDER) { File.read(battle) })
    end
    bad_words
  end

  def count_bad_words(file)
    bad_words = 0
    file.split.each do |word|
      bad_words += 1 if RussianObscenity.obscene?(word)
    end
    bad_words += file.count('*')
    bad_words
  end
end
