require_relative 'parser.rb'
require_relative 'participant'
require_relative 'battle'
require_relative 'table'
require 'terminal-table'

# Display top obscene battlers
class TopObsceneBattlers
  def show_top(limit)
    top = BattlerList.new.top_by_bad_words(limit.to_i)
    puts Terminal::Table.new CreateTable.table(top)
  end
end

# Prepare battler list for display
class BattlerList
  def initialize
    @battlers = {}
  end

  def rappers
    Parser.getting_path.each(&method(:add_rappers))
    @battlers
  end

  def add_rappers(filename)
    unique_name = RapperUniqueName.new(filename).rapper_name
    battle = Battle.new(filename)
    rapper = @battlers[unique_name]
    @battlers[unique_name] =
      rapper ? rapper.add_battle(battle) : Rapper.new(unique_name, [battle])
  end

  def top_by_bad_words(limit)
    rappers.values.sort_by { |rapper| - rapper.bad_words_count }.first(limit)
  end
end
