# This is class BattleInfo
class BattleInfo
  include Helper

  def the_most_obscene_rappers(top_words)
    puts Terminal::Table.new rows: sorted_rapers.first(top_words).map(&:show)
  end

  def find_favorite_words(raper_name, top_words = 30)
    if rapers_names.include? raper_name
      FavoriteWords.new(rapers.find do |raper|
        raper.name == raper_name
      end, top_words).show
    else
      puts "Рэпер #{raper_name} не известен мне. Зато мне известны:"
      rapers_names.each { |raper| puts raper }
    end
  end

  private

  def sorted_rapers
    rapers.sort_by(&:count_bad_words).reverse
  end

  def rapers
    RaperListObjects.new(rapers_names).list_rapers
  end

  def rapers_names
    RaperList.new.names
  end
end
