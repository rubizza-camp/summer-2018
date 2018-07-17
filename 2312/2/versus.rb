require './battle'
require './battlers_table'
require './modules'

# info[rapper_name] = [num_of_battles, num_of_rounds, aver_all_words_per_round, whole_num_of_bad_words,
#                             aver_num_of_bad_words_per_battle, words_top_list{}, all_words_amount]

# shutting reek down because I don't have any idea, how to rewrite my code without this error
# :reek:InstanceVariableAssumption
# it is main class, it's analyzes all battle texts in current directory
class Versus
  attr_reader :all_battles, :battlers_info, :names_array

  include FillMethods
  include ReturnInfo

  def initialize
    collect_all_battles
    @names_array = []
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
    @all_battles = Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == '' && File.basename(entry) != 'Gemfile'
    end
    @all_battles.sort!
  end

  def top_bad(num_top)
    @battlers_info.keys.each { |rapper| @battlers_info = analyze(rapper) }
    BattlersTable.new(@battlers_info, num_top).print
  end

  def collect_names
    info = {}
    @names_array = fill_names_array(@all_battles)
    @names_array.each { |name| info[name] = [0, 0, 0.0, 0, 0.0, {}, 0] }
    @battlers_info = info
  end

  def collect_battles_of(rapper)
    rapper_battles = []
    @all_battles.each do |battle|
      rapper_battles << battle if battle.partition(/( против | vs | VS )/).first.include?(rapper)
    end
    rapper_battles
  end

  def analyze(rapper)
    rapper_battles = collect_battles_of(rapper)
    @battlers_info[rapper][0] = rapper_battles.size
    fill_counted_info(rapper, rapper_battles)
    @battlers_info.sort.to_h
  end
end

Versus.new.run
