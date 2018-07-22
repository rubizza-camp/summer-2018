require_relative 'InitializingParticipants'
# Displays a list of favorite phrases or a list of participants
class PrintBestWord < InitializingParticipants
  def self.name_battle(name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    (0..name_batlers.length - 1).step(1) do |count|
      puts name_batlers[count]
    end
  end

  def self.best_word_list_in(num_bat, name)
    (0...name_batlers.length).step(1) do |count_qw|
      puts "#{num_bat[5][count_qw][0]} - #{num_bat[5][count_qw][1]}" if num_bat[0].include?(name)
    end
  end

  def self.best_word_list(array, name)
    array.each do |li|
      best_word_list_in(li, name)
    end
  end
end
