class Battler
  ROUND_IN_BATLE = 3

  attr_reader :name_bat, :params
  def initialize(name_bat, all_text)
    @name_bat = name_bat
    count_curse = counting_curse(all_text)
    count_bat = all_text.size
    @params = {
      count_bat: count_bat,
      count_curse: count_curse,
      curse_bat: curse_battle(count_curse, count_bat),
      word_round: counting_word(all_text, count_bat)
    }
  end

  def show
    [@name_bat, @params[:count_bat], @params[:count_curse], @params[:curse_bat], @params[:word_round]]
  end

  private

  def curse_battle(count_curse, count_bat)
    (count_curse.to_f / count_bat).round(2)
  end

  def counting_curse(all_text)
    change_text = RussianObscenity.sanitize(all_text.join(' '), '<CR>')
    change_text.scan('<CR>').size + change_text.count('*')
  end

  def counting_word(all_text, count_bat)
    all_text.join(' ').split.size / (ROUND_IN_BATLE * count_bat)
  end
end
