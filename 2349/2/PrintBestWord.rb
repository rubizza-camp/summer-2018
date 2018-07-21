require_relative 'InitializingParticipants'
# Displays a list of favorite phrases or a list of participants
class PrintBestWord < InitializingParticipants
  def self.name_battle(name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    (0..name_batlers.length - 1).step(1) do |count|
      puts name_batlers[count]
    end
  end

  def self.best_word_list(array, name)
    array.each do |li|
      (0...name_batlers.length).step(1) do |count_qw|
        puts "#{li[5][count_qw][0]} - #{li[5][count_qw][1]}" if li[0] == name
      end
    end
  end
end
