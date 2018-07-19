# Check battles
class BattleCheck
  include PrepareBattlersTableHelper
  include BattlerAsRow
  def describe_battlers(top_bad_words)
    battlers = []
    PrepareBattlersTableHelper.prepare_battlers_table(battlers)
    display_top_battlers(battlers, top_bad_words)
  end

  private

  def display_top_battlers(battlers, top_bad_words)
    rows = battlers[0...top_bad_words].map { |battler| BattlerAsRow.get_battler_as_row(battler) }
    table = Terminal::Table.new rows: rows
    puts table
  end
end
