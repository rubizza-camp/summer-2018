class Battler
  ROUND_IN_BATTLE = 3

  attr_reader :name, :params
  def initialize(name, texts)
    @name = name
    curses = counting_curses(texts)
    @params = {
      battles: texts.size,
      curses: curses,
      curses_per_battle: average_curses(curses, texts.size),
      words_per_round: average_words(texts)
    }
  end

  def show
    [@name, @params[:battles], @params[:curses], @params[:curses_per_battle], @params[:words_per_round]]
  end

  private

  def average_curses(curses, battles)
    (curses.to_f / battles).round(2)
  end

  def counting_curses(texts)
    change_text = RussianObscenity.sanitize(texts.join(' '), '<CR>')
    change_text.scan('<CR>').size + change_text.count('*')
  end

  def average_words(texts)
    texts.join(' ').split.size / (ROUND_IN_BATTLE * texts.size)
  end
end
