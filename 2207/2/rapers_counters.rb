require_relative 'counters'
require_relative 'service'
# The module RapersCounters is responsible for moduling hash with
# needed keys and values for class Raper to initializing.
module RapersCounters
  include Counters

  def add_raper(raper)
    titles_of_the_current_raper = find_rapers_titles(raper)
    Raper.new(moduling_hash(raper, titles_of_the_current_raper))
  end

  def moduling_hash(raper, titles_of_the_current_raper)
    {
      name: raper,
      battles:  titles_of_the_current_raper.size,
      bad_words: bad_words(raper),
      bad_in_round: bad_in_round(raper, titles_of_the_current_raper),
      words_in_round: words_in_round(raper)
    }
  end

  def bad_words(raper)
    count_bad(find_rapers_titles(raper))
  end

  def bad_in_round(raper, current_raper_titles)
    (bad_words(raper).to_f / current_raper_titles.size).round(2)
  end

  def words_in_round(raper)
    count_normal(find_rapers_titles(raper))
  end

  # This method smells of :reek:UtilityFunction
  # I think it will be better to paste this code here in couse of small project
  def find_rapers_titles(raper)
    rapers_titles = []
    Dir.chdir(Service.path) do
      Dir.glob("*#{raper}*").each do |title|
        rapers_titles << title if title.split('против').first.include? raper
      end
    end
    rapers_titles
  end
end
