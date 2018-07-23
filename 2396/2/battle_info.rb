# This is class BattleInfo
class BattleInfo
  include Helper

  def the_most_obscene_rappers(top_words)
    puts Terminal::Table.new rows: sorted_rapers.first(top_words).map(&:show)
  end

  def find_favorite_words(raper_name, top_words = 30)
    if rapers_names.include? raper_name
      FavoriteWordsCounter.new(rapers.find do |raper|
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
    rapers_names.map do |raper_name|
      Raper.new(raper_name, Helper.find_rapper_battles(battles, raper_name))
    end
  end

  def rapers_names
    names = []
    Dir.chdir(Battle::FOLDER) do
      Dir.glob('*против*').map do |name|
        names.push(Helper.find_names(name)).delete('')
      end
    end
    Helper.merge_similar_names(names.flatten.uniq)
  end

  def battles
    Dir.chdir(Battle::FOLDER) do
      Dir.glob('*против*').map { |name| Battle.new(name, File.read(name)) }
    end
  end
end
