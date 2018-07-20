require 'terminal-table'

# BattlersTable prints a table of data, you provide to it
class BattlersTable
  def initialize(battlers, num_top)
    @battlers = battlers
    @counter = -1
    @table = []
    @num_top = num_top
  end

  def print
    if @num_top.zero?
      puts ''
      exit
    end
    create_table
    puts Terminal::Table.new rows: @table[0...@num_top]
  end

  private

  def create_table
    @battlers.sort_by { |_name, info| info.stats.rapper_stats[:bad_words_num] }.reverse.to_h.keys.each do |name|
      @counter += 1
      fill_table(name)
    end
  end

  def fill_table(name)
    info = @battlers[name]
    @table[@counter] = [name]
    bad_words_num = info.stats.rapper_stats[:bad_words_num]
    @table[@counter] << "#{info.overall[:battles_num]} battles" << "#{bad_words_num} bad words"
    fill_stats_in_table_from(info)
  end

  def fill_stats_in_table_from(info)
    stats = info.stats.rapper_stats
    @table[@counter] << "#{stats[:bad_words_per_battle]} bad/battle" << "#{stats[:words_per_round]} words/round"
  end
end
