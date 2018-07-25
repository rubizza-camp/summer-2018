require './battlers_table'
require './rapper'
require './battle'
require './command_parser'

# battlers = {rapper_name: Rapper.new(rapper_name), , {}, ...}

# it is main class, it's analyzes all battle texts in current directory
class Versus
  def initialize
    @battlers_names = []
    @battlers = {}
    @to_do = CommandParser.new.to_do
    @all_battles_files = []
    collect_all_battles_files
    collect_battlers
  end

  def run
    top_bad(@to_do[:top_bad_words])
  end

  def top_bad(num_top = 300)
    BattlersTable.new(@battlers, num_top).print
  end

  def collect_all_battles_files
    @all_battles_files = Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == '' && File.basename(entry) != 'Gemfile'
    end.sort!
  end

  def collect_battlers
    battlers_names = fill_battlers_names_array.uniq.sort
    battlers_names.each { |rapper_name| @battlers[rapper_name] = Rapper.new(rapper_name, @all_battles_files) }
    @battlers.sort.to_h
  end

  def fill_battlers_names_array
    @all_battles_files.flat_map { |battle_file_path| Battle.new(battle_file_path).battlers_names }
  end
end

Versus.new.run
