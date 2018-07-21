require_relative './analyze.rb'
require 'russian_obscenity'
require 'terminal-table'

RussianObscenity.dictionary = [:default, 'dictionary.yml']

# Form the table of top battlers with the biggest count of foul words
class TopBattlers
  attr_reader :rapers, :result

  def initialize
    @rapers = FileParser.new.read_files
    @result = []
  end

  def result_table(count)
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

  def sort_list
    @rapers.sort_by do |_key, value|
      Bad.bad_words_counter(value.join(' '))
    end.reverse!
  end
end

# Bad words counter
class Bad
  def self.bad_words_counter(text)
    RussianObscenity.find(text).inject(0) do |count, bad|
      count + text.split(' ').count(bad)
    end
  end
end
