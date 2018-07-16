load 'battler.rb'
load 'modules.rb'

# Class find top bad words from texts
class BadWords
  include SomeMethods
  attr_reader :battlers, :methods
  def initialize(num)
    @battlers = []
    @methods = create_methods
    Dir[File.expand_path('.') + '/rap-battles/*'].each do |file|
      collect_data(file)
    end
    @battlers.each(&:do_bw_battle)
    output_data(num)
  end

  private

  def create_methods
    Hash.new(proc { |obj, data| obj.update(data) }).merge!(nil => proc { |*args| battlers << Battler.new(*args) })
  end

  # This method smells of :reek:TooManyStatements
  def collect_data(file)
    name = SomeMethods.parse_name(file)
    data = SomeMethods.parse_data(file)
    answer = battlers.find { |battler| SomeMethods.compare_names(battler.name, name) }
    methods[answer].call(answer ? answer : name, data)
  end

  def output_data(num)
    rows = []
    battlers.sort_by!(&:bw_battle).reverse![0..num - 1].each { |battler| rows << battler.do_str }
    table = Terminal::Table.new rows: rows
    puts table
  end
end
