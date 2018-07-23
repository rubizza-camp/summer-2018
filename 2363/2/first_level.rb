require_relative 'battler'
require_relative 'parser'
require_relative 'comparenames'
require 'terminal-table'

# Class find top bad words from texts
class BadWordsParser
  attr_reader :battlers, :methods_add_battler

  def initialize
    @battlers = []
    @methods_add_battler = Hash.new(proc { |obj, data| obj.update_stats(data) })
    @methods_add_battler[nil] = proc do |name, data|
      battlers << Battler.new(name)
      battlers.last.update_stats(data)
    end
  end

  def call(number_words_output, path)
    Dir[path].each do |file|
      collect_data(file)
    end
    prepare_data_for_output
    output_data(collect_output_rows(number_words_output))
  end

  private

  def collect_data(file)
    battler_exists?(Parser.new(file).call)
  end

  def battler_exists?(received_data)
    name = received_data[:name]
    answer = battlers.find { |battler| CompareNames.new(battler.name, name).call }
    methods_add_battler[answer].call(answer ? answer : name, received_data[:stats])
  end

  def prepare_data_for_output
    @battlers.each(&:count_avg_stats)
    @battlers.sort_by! { |item| item.avg_stats[:bad_words_per_battle] }
  end

  def collect_output_rows(number_words_output)
    @battlers.reverse![0..number_words_output - 1].each_with_object([]) do |battler, rows|
      rows << battler.create_str_for_output
    end
  end

  def output_data(rows)
    table = Terminal::Table.new rows: rows
    puts table
  end
end
