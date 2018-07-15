require 'russian_obscenity'

# :reek:TooManyInstanceVariables
# Class for our tasks
class Rapper
  attr_reader :name, :battles, :bad_words, :total_words, :total_rounds, :average_bad

  def initialize(rapper_name, rapper_battle)
    @name = rapper_name
    @battles = [rapper_battle]
    @bad_words = 0
    @total_words = 0
    @total_rounds = 0
    @average_bad = 0
  end

  def push_one_battle(some_battle)
    battles.push(some_battle)
  end

  def print
    puts name.ljust(23) + '| ' + battles_to_s + '| ' + bad_words_to_s + '| ' + average_bad_to_s + '| ' + average_rounds
  end

  def choose_better_name(other_name)
    @name = name.length > other_name.length ? other_name : name
  end

  # :reek:TooManyStatements
  # :reek:NestedIterators
  def count_words
    battles.each do |battle_name|
      rounds = 0
      IO.foreach(battle_name.to_s) do |line|
        count_words_in_line(line)
        rounds += 1 if line[/[Рр]аунд ?\d/]
      end
      @total_rounds += rounds.zero? ? 1 : rounds
      @average_bad = bad_words.to_f / battles.size
    end
  end

  def count_words_in_line(line)
    words_arr = line.split
    words_arr.each { |word| @bad_words += 1 if word.include?('*') }
    @bad_words += RussianObscenity.find(line).size
    @total_words += words_arr.length
  end

  private

  def battles_to_s
    s_battles = "#{battles.size} баттл#{ending_of_numb_battles}"
    s_battles.ljust(10)
  end

  def bad_words_to_s
    s_bad_words = "#{bad_words} нецензурн#{ending_of_nezenz_adj} слов#{ending_of_nezenz_noun}"
    s_bad_words.ljust(22)
  end

  def average_bad_to_s
    s_average = format('%1.2f', average_bad) + ' нецензурных слова на баттл'
    s_average.ljust(34)
  end

  def average_rounds
    average = format('%1.2f', total_words.to_f / total_rounds) + ' слова в раунде в среднем'.ljust(21)
    average
  end

  def ending_of_numb_battles
    two_last_digs = battles.size.digits.reverse.last(2).join.to_i
    return 'ов' if (11..19).cover?(two_last_digs)
    case two_last_digs.digits[0]
    when 1
      return ''
    when 2..4
      return 'а'
    end
    'ов'
  end

  def ending_of_nezenz_adj
    two_last_digits = bad_words.digits.reverse.last(2).join.to_i
    return 'ых' if (11..19).cover?(two_last_digits)
    return 'ое' if two_last_digits.digits[0] == 1
    'ых'
  end

  def ending_of_nezenz_noun
    two_last_digits = bad_words.digits.reverse.last(2).join.to_i
    return '' if (11..19).cover?(two_last_digits)
    case two_last_digits.digits[0]
    when 1
      return 'о'
    when 2..4
      return 'а'
    end
    ''
  end
end
