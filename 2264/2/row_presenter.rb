# This class is used for creating row
class RowPresenter < RapperData
  def initialize(rapper)
    @rapper = rapper
    show_rapper_info
  end

  def show_rapper_info
    [@rapper.rapper_name.to_s,
     "#{@rapper.count_avg_battles} баттлов",
     "#{@rapper.count_bad_words} нецензурных слов",
     "#{@rapper.count_avg_bad_words_in_battle} слова на баттл",
     "#{@rapper.count_avg_words_in_round} слов в раунде"]
  end
end
