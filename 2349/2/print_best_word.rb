# Displays a list of favorite phrases or a list of participants
class PrintBestWord
  attr_reader :array, :all_batlers, :name

  def initialize(array, all_batlers, name)
    @array = array
    @all_batlers = all_batlers
    @name = name
  end

  def top_best_words
    if all_batlers.include?(name)
      best_word_list
    else
      name_battle
    end
  end

  private

  def name_battle
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    (0..all_batlers.length - 1).step(1) do |count|
      puts all_batlers[count]
    end
  end

  def best_word_list_in(num_bat)
    (0...all_batlers.length).step(1) do |count_qw|
      puts "#{num_bat[5][count_qw][0]} - #{num_bat[5][count_qw][1]}" if num_bat[0].include?(name)
    end
  end

  def best_word_list
    array.each do |li|
      best_word_list_in(li)
    end
  end
end
