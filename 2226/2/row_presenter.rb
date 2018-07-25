# Class for rapper decorator
class RowPresenter < Rapper
  def initialize(rapper)
    @rapper = rapper
  end

  def russian_battles
    Russian.p(@rapper.number_of_battles, 'баттл', 'баттла', 'баттлов').to_s
  end

  def show_rapper_info
    [@rapper.rapper_name.to_s,
     "#{@rapper.number_of_battles} #{russian_battles}",
     "#{@rapper.number_of_swear_words} нецензурных слов",
     "#{@rapper.average_number_swearing_words_in_battles.round(2)} слов на баттл",
     "#{@rapper.average_number_words_in_round} слова в раунде"]
  end
end
