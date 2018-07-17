require './battle'
require './battlers_table'
require './modules'

# info_about_battlers[rapper_name] = [num_of_battles, num_of_rounds, aver_all_words_per_round, whole_num_of_bad_words,
#                             aver_num_of_bad_words_per_battle, words_top_list{}, all_words_amount]

# shutting reek down because I don't have any idea, how to rewrite my code without this error
# :reek:InstanceVariableAssumption
# it is main class, it's analyzes all battle texts in current directory
class Versus
  attr_reader :all_battles_paths, :info_about_battlers, :battlers_names

  include FillMethods
  include ReturnInfo

  def initialize
    collect_all_battles
    @battlers_names = []
    collect_names
  end

  def run
    ARGV.each do |command|
      parameter = command.split('=')[1].to_i
      top_bad(parameter)
    end
  end

  private

  def collect_all_battles
    @all_battles_paths = Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == '' && File.basename(entry) != 'Gemfile'
    end
    @all_battles_paths.sort!
  end

  def top_bad(num_top)
    @info_about_battlers.keys.each { |rapper| @info_about_battlers = analyze_rapper(rapper) }
    BattlersTable.new(@info_about_battlers, num_top).print
  end

  def collect_names
    info_buffer = {}
    @battlers_names = fill_battlers_names_array
    @battlers_names.each { |name| info_buffer[name] = [0, 0, 0.0, 0, 0.0, {}, 0] }
    @info_about_battlers = info_buffer
  end

  def collect_battles_of(rapper)
    rapper_battles = []
    @all_battles_paths.each do |battle_path|
      rapper_battles << battle_path if battle_path.partition(/( против | vs | VS )/).first.include?(rapper)
    end
    rapper_battles
  end

  def analyze_rapper(rapper)
    rapper_battles = collect_battles_of(rapper)
    @info_about_battlers[rapper][0] = rapper_battles.size
    fill_counted_info(rapper, rapper_battles)
    @info_about_battlers.sort.to_h
  end
end

Versus.new.run
