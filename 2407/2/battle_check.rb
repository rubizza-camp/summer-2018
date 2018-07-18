# Check battles
class BattleCheck
  include SomeMethods
  def describe_battlers(top_bad_words)
    battlers = []
    SomeMethods.prepare_battlers_table(battlers)
    display_top_battlers(battlers, top_bad_words)
  end

  private

  def display_top_battlers(battlers, top_bad_words)
    rows = []
    top_bad_words.times do |ind|
      rows << SomeMethods.get_battler_as_row(battlers[ind])
    end
    table = Terminal::Table.new rows: rows
    puts table
  end
end
