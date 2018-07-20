require 'russian_obscenity'
require_relative 'class_correct_strings_for_rapper'

# ancestor class for our tasks
class Rapper
  attr_reader :name, :battles

  def initialize(rapper_name, rapper_battle)
    @name = rapper_name
    @battles = [rapper_battle]
  end

  def push_one_battle(some_battle)
    battles.push(some_battle)
    self
  end

  def choose_better_name(other_name)
    @name = name.length > other_name.length ? other_name : name
  end
end

# class for our tasks
class BadRapper < Rapper
  attr_reader :bad_words, :total_words, :total_rounds, :average_bad

  def initialize(name, battle_name)
    super(name, battle_name)
    @bad_words = 0
    @total_words = 0
    @total_rounds = 0
    @average_bad = 0
  end

  def print
    average = total_words.fdiv(total_rounds)
    str = name.ljust(23) + '| ' + CorrectStrings.full_string(battles, bad_words, average_bad)
    puts str + CorrectStrings.average_rounds(average)
  end

  def count_words
    battles.each { |battle_name| count_words_in_battle(battle_name) }
    average_bad
  end

  def count_words_in_battle(battle_name)
    rounds = 0
    IO.foreach(battle_name.to_s) do |line|
      count_words_in_line(line)
      rounds += 1 if line[/[Рр]аунд ?\d/]
    end
    update_for_count_words(rounds)
  end

  def count_words_in_line(line)
    words_arr = line.split
    words_arr.each { |word| @bad_words += 1 if word.include?('*') }
    @bad_words += RussianObscenity.find(line).size
    @total_words += words_arr.length
  end

  def update_for_count_words(rounds)
    @total_rounds += rounds.zero? ? 1 : rounds
    @average_bad = bad_words.to_f / battles.size
  end
end
