require_relative 'raper'
require_relative 'counters'
# The class Service is responsible for main deff's and variables that are used in another classes

class Service
  # This method smells of :reek:Attribute
  attr_accessor :rapers

  def initialize
    @rapers = []
  end

  def self.path
    @path = 'texts'
  end

  # This method smells of :reek:UtilityFunction
  def find_rapers
    rapers_names_only ||= begin
      rapers_names_only = []
      Dir.chdir(Service.path) do
        Dir.glob('*против*').each do |title|
          rapers_names_only << title.split(' против').first.strip
        end
      end
      rapers_names_only.uniq
    end
  end

  def analize_by_obscenity(top_bad_words)
    find_rapers.each { |file| @rapers << Raper.add_raper(file) }
    @rapers.sort_by!(&:bad_in_round).reverse!
    show_top_rapers(@rapers, top_bad_words)
  end

  def show_top_rapers(rapers, top_bad_words)
    rows = []
    top_bad_words.to_i.times { |name_of_participant| rows << get_participant_as_row(rapers[name_of_participant]) }
    table = Terminal::Table.new rows: rows
    puts table
  end

  # This method smells of :reek:UtilityFunction
  def get_participant_as_row(raper)
    row = [raper.name, "#{raper.battles} батлов"]
    row += ["#{raper.bad_words} нецензурных слов"]
    row += ["#{raper.bad_in_round} слов на батл"]
    row + ["#{raper.words_in_round} слов в раунде"]
  end
end
