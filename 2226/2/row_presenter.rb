# Class for raper decorator
class RowPresenter < Raper
  def initialize(raper)
    @raper = raper
    show_raper_info
  end

  def russian_battles
    Russian.p(@raper.number_of_battles, 'баттл', 'баттла', 'баттлов').to_s
  end

  def show_raper_info
    [@raper.raper_name.to_s,
     "#{@raper.number_of_battles} #{russian_battles}",
     "#{@raper.number_of_swear_words} нецензурных слов",
     "#{@raper.average_number_swearing_words_in_battle.round(2)} слов на баттл",
     "#{@raper.average_number_words_in_round} слова в раунде"]
  end
end
