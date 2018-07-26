require_relative 'raper'
require_relative 'counters'
# The class Service is responsible for main deff's and variables that are used in another classes

class Service
  # This method smells of :reek:Attribute
  attr_accessor :rapers

  PATH = 'texts'.freeze

  def initialize
    @rapers = []
  end

  # This method smells of :reek:UtilityFunction
  def find_rapers
    Dir.chdir(PATH) do
      Dir.glob('*против*').map { |title| title.split(' против').first.strip }
    end.uniq
  end

  def analize_by_obscenity(top_bad_words)
    find_rapers.each { |file| @rapers << Raper.add_raper(file) }
    @rapers.sort_by!(&:bad_in_round).reverse!
    show_top_rapers(@rapers, top_bad_words)
  end

  # This method smells of :reek:UtilityFunction
  def get_participant_as_row(raper)
    [raper.name, "#{raper.battles} батлов", "#{raper.bad_words} нецензурных слов",
     "#{raper.bad_in_round} слов на батл", "#{raper.words_in_round} слов в раунде"]
  end

  def show_top_rapers(rapers, top_bad_words)
    rows = rapers.map { |item| get_participant_as_row(item) }.take(top_bad_words)
    table = Terminal::Table.new rows: rows
    puts table
  end
end
