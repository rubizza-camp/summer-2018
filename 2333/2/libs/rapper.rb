require 'russian_obscenity'

# class Rapper
class Rapper
  attr_reader :name, :battles

  def initialize(name, battles)
    @name = name
    @battles = battles
  end

  def all_mats
    mats = 0
    RussianObscenity.dictionary = [:default, './my_dictionary.yml']
    RussianObscenity.find(@battles.join(' ')).each do |word|
      mats += battles_words.count(word)
    end
    mats
  end

  def battles_words
    @battles.join(' ').split(/[^[а-яА-Я*ёЁa-zA-Z]]+/)
  end

  def mats_on_battle
    (all_mats / @battles.count.to_f).round(2)
  end

  def words_on_round
    battles_words.count / (@battles.count * 3)
  end
end
