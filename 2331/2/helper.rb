require 'russian_obscenity'

class Helper
  def self.words_on_round(battles)
    all_words(battles).count / (battles.count * 3)
  end

  def self.sort_data(data)
    data.sort_by do |_rapper, info|
      info['bad_words_on_battle']
    end.reverse.to_h
  end

  def self.obscene_words(battles)
    count = 0
    RussianObscenity.dictionary = [:default, './my_dictionary.yml']
    RussianObscenity.find(battles.join(' ')).each do |obscene_word|
      count += all_words(battles).count(obscene_word)
    end
    count
  end

  def self.all_words(battles)
    battles.join(' ').split(/[^A-Za-zА-Яа-яёЁ*]+/)
  end

  def self.preposition?(word)
    prepositions = File.read('prepositions.txt').split(',')
    prepositions.include? word
  end
end
