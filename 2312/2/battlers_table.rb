require 'terminal-table'

# BattlersTable prints a table of data, you provide to it
class BattlersTable
  def initialize(battlers, num_top)
    @battlers = battlers
    @counter = -1
    @table = []
    @table = create_table(num_top)
  end

  def print
    puts Terminal::Table.new rows: @table
  end

  private

  def create_table(num_top)
    @battlers.sort_by { |_name, info| info.stats.words_info[:bad_words_num] }.reverse.to_h.keys.each do |name|
      @counter += 1
      fill_table_global(name)
    end
    @table[0...num_top]
  end

  def fill_table_global(name)
    info = @battlers[name]
    @table[@counter] = [name]
    @table[@counter] << "#{info.overall[:battles_num]} battles" << "#{info.stats.words_info[:bad_words_num]} bad words"
    fill_table_second(info)
  end

  def fill_table_second(info)
    stats = info.stats.words_info
    @table[@counter] << "#{stats[:bad_words_per_battle]} bad/battle" << "#{stats[:words_per_round]} words/round"
  end
end
