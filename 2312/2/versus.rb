require 'terminal-table'
require './battle_analyzer'

# info[rapper_name] = [num_of_battles, num_of_rounds, aver_all_words_per_round, whole_num_of_bad_words,
#                             aver_num_of_bad_words_per_battle, words_top_list{}

module AdditionalMethods
  def return_info(rapper, elem)
    @info_about[rapper][elem]
  end

  def fill_counted_info_first(rapper)
    @info_about[rapper][2] = (return_info(rapper, 6).to_f / return_info(rapper, 1)).round(2)
  end

  def fill_counted_info_second(rapper)
    @info_about[rapper][4] = (return_info(rapper, 3).to_f / return_info(rapper, 0)).round(2)
  end

  def fill_table_first(rapper, output_table, counter)
    output_table[counter] = [rapper]
    output_table[counter] << "#{return_info(rapper, 0)} battles" << "#{return_info(rapper, 3)} bad words"
    output_table
  end

  def fill_table_second(rapper, output_table, counter)
    output_table[counter] << "#{return_info(rapper, 4)} bad/battle" << "#{return_info(rapper, 2)} words/round"
    output_table
  end
end

# shutting reek down because I don't have any idea, how to rewrite my code without this error
# :reek:InstanceVariableAssumption
# it is main class, it's analyzes all battle texts if current directory
class VersusAnalyzer
  attr_reader :all_battles, :info_about, :names_array

  include AdditionalMethods

  def initialize
    collect_battles
    @names_array = []
    collect_names
  end

  def collect_battles
    @all_battles = Dir.entries('./').select do |entry|
      !entry.start_with?('.') && File.exist?(entry) && File.extname(entry) == ''
    end
    @all_battles.sort!
  end

  def run
    ARGV.each do |command|
      parameter = command.split('=')[1].to_i
      top_bad(parameter)
    end
  end

  def top_bad(num_top)
    @info_about.keys.each { |rapper| @info_about = analyze(rapper) }
    output_table = []
    fill_table_global(output_table)
    puts Terminal::Table.new rows: output_table[0...num_top]
  end

  def fill_table_global(output_table, counter = -1)
    @info_about.sort_by { |_key, value| value[3] }.reverse.to_h.keys.each do |rapper|
      counter += 1
      output_table = fill_table_first(rapper, output_table, counter)
      output_table = fill_table_second(rapper, output_table, counter)
    end
  end

  def collect_names
    info = {}
    fill_names_array
    @names_array.each { |name| info[name] = [0, 0, 0.0, 0, 0.0, {}, 0] }
    @info_about = info
  end

  def fill_names_array
    @all_battles.each do |battle|
      rapper = battle.partition(/( против | vs | VS )/).first + ' & '
      splitted_rapper = rapper.split(' & ')
      @names_array << splitted_rapper.first.strip
      @names_array << splitted_rapper[1].strip if BattleAnalyzer.new(battle).double?
    end
  end

  def collect_battles_of(rapper)
    rapper_battles = []
    @all_battles.each do |battle|
      rapper_battles << battle if battle.partition(/( против | vs | VS )/).first.include?(rapper)
    end
    rapper_battles
  end

  def fill_counted_info(rapper, rapper_battles)
    fill_info(rapper, rapper_battles, @info_about[rapper])
    fill_counted_info_first(rapper)
    fill_counted_info_second(rapper)
  end

  def fill_info(rapper, rapper_battles, info)
    rapper_battles.each do |battle|
      info = BattleAnalyzer.new(battle).fill_info(info, rapper)
    end
    @info_about[rapper] = info
  end

  def analyze(rapper)
    rapper_battles = collect_battles_of(rapper)
    @info_about[rapper][0] = rapper_battles.size
    fill_counted_info(rapper, rapper_battles)
    @info_about.sort.to_h
  end
end

VersusAnalyzer.new.run
