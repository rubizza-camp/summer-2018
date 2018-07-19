require './battlers_table'
require './rapper'
require './battle'

# battlers = {rapper_name: Rapper.new(rapper_name), , {}, ...}

# shutting reek down because I don't have any idea, how to rewrite my code without this error
# it is main class, it's analyzes all battle texts in current directory
class Versus
  def initialize
    @battlers_names = []
    @battlers = {}
    collect_battlers
  end

  def run
    ARGV.each do |command|
      parameter = command.split('=')[1].to_i
      top_bad(parameter)
    end
  end

  def top_bad(num_top)
    BattlersTable.new(@battlers, num_top).print
  end

  def self.all_battles_files
    Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == '' && File.basename(entry) != 'Gemfile'
    end.sort!
  end

  def collect_battlers
    battlers_names = Versus.fill_battlers_names_array.uniq.sort
    battlers_names.each { |rapper_name| @battlers[rapper_name] = Rapper.new(rapper_name, Versus.all_battles_files) }
    @battlers.sort.to_h
  end

  def self.fill_battlers_names_array
    Versus.all_battles_files.flat_map { |battle_file_path| Versus.extract_battlers_names(battle_file_path) }
  end

  def self.extract_battlers_names(battle_file_path)
    rapper_name = battle_file_path.split(/( против | vs | VS )/).first + ' & '
    rappers_names = rapper_name.split(' & ')
    battlers_names = [rappers_names.first.strip]
    battlers_names << rappers_names.last.strip if Battle.paired?(battle_file_path)
    battlers_names
  end
end

Versus.new.run
