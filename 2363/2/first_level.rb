load 'battler.rb'
load 'modules.rb'

# Class find top bad words from texts
class BadWordsParser
  include SomeMethods
  attr_reader :battlers, :methods_add_battler
  def initialize(num)
    @battlers = []
    @methods_add_battler = create_methods
    Dir[File.expand_path('.') + '/rap-battles/*'].each do |file|
      collect_data(file)
    end
    @battlers.each(&:create_bad_words_per_battle)
    output_data(num)
  end

  private

  def create_methods
    Hash.new(proc { |obj, data| obj.update_stats(data) }).merge!(nil => proc { |*args| battlers << Battler.new(*args) })
  end

  def collect_data(file)
    parse(file)
    answer = battlers.find { |battler| SomeMethods.compare_names(battler.name, name_from_file) }
    methods_add_battler[answer].call(answer ? answer : name_from_file, data)
  end

  def output_data(num)
    rows = []
    battlers.sort_by!(&:bad_words_per_battle).reverse![0..num - 1].each do |battler|
      rows << battler.create_str_for_output
    end
    table = Terminal::Table.new rows: rows
    puts table
  end
end
