require './top_bad_words.rb'
require './top_words.rb'
require './rapper.rb'

# This class is needed for second level of task
class SecondLevel
  def initialize(most = 30, name = 'None')
    @most = !most.empty? ? most.to_i : 30
    @name = name
    @second_level = TopWord.new(name)
    @check = TopBadWords.new
  end

  def print_top_words
    @second_level.ready_top_words
    @second_level.res(@most)
  end

  def battlers_list
    @check.battlers_names
    @check.battlers
  end

  def name_check
    battlers = battlers_list
    if !battlers.include?(@name)
      puts 'Я не знаю рэпера ' + @name + ', но знаю таких: '
      battlers.each { |battler| puts battler }
    else
      print_top_words
    end
  end
end
