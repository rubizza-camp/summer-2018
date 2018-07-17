require_relative './parameters_parser.rb'
require_relative './analyze.rb'
require 'russian_obscenity'
require 'terminal-table'

RussianObscenity.dictionary = [:default, 'dictionary.yml']
# Form the table of top battlers with the biggest count of foul words
# :reek:UtilityFunction
class TopBattlers
  attr_reader :rapers, :result

  def initialize
    @rapers = FileParser.new.read_files
    @result = []
  end

  def result_table(count = 20)
    sort_list.first(count).each do |array|
      @result << Analyze.new(array.first, array.last).row
    end
    show(result)
  end

  private

  def show(array)
    table = Terminal::Table.new(rows: array)
    puts table
  end

  def bad_words_searching(text)
    RussianObscenity.find(text).inject(0) do |count, bad|
      count + text.split(' ').count(bad)
    end
  end

  def sort_list
    @rapers.sort_by do |_key, value|
      bad_words_searching(value.join(' '))
    end.reverse
  end
end
