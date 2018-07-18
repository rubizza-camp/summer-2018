require_relative 'battler.rb'
require_relative 'modules.rb'

# Class find top bad words from texts
class BadWordsParser
  include SomeMethods
  attr_reader :battlers, :methods_add_battler
  def initialize
    @battlers = []
    @methods_add_battler = Hash.new(proc { |obj, data| obj.update_stats(data) })
    @methods_add_battler[nil] = proc do |name, data|
      battlers << Battler.new(name)
      battlers.last.update_stats(data)
    end
  end

  def call(num)
    Dir[File.expand_path('.') + '/rap-battles/*'].each do |file|
      collect_data(file)
    end
    output_data(collect_output_rows(num))
  end

  private

  def collect_data(file)
    parse(file)
    answer = battlers.find { |battler| SomeMethods.compare_names(battler.name, name_from_file) }
    methods_add_battler[answer].call(answer ? answer : name_from_file, data)
  end

  def collect_output_rows(num)
    @battlers.each(&:create_bad_words_per_battle)
    rows = []
    battlers.sort_by!(&:bad_words_per_battle).reverse![0..num - 1].each_with_object('') do |battler|
      rows << battler.create_str_for_output
    end
    rows
  end

  def output_data(rows)
    table = Terminal::Table.new rows: rows
    puts table
  end
end
