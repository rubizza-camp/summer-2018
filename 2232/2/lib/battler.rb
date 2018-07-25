require_relative 'helpers/battler_params'

class Battler
  include BattlerParams

  attr_reader :name, :params
  def initialize(name, texts)
    @name = name
    curses = BattlerParams.counting_curses(texts)
    @params = {
      battles: texts.size,
      curses: curses,
      curses_per_battle: BattlerParams.average_curses(curses, texts.size),
      words_per_round: BattlerParams.average_words(texts)
    }
  end

  def show
    [@name, @params[:battles], @params[:curses], @params[:curses_per_battle], @params[:words_per_round]]
  end
end
