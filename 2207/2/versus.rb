require 'terminal-table'
require 'trollop'
require_relative 'Raper'
require_relative 'BattleCounters'
require_relative 'RapersCounters'
# rubocop:disable Style/GlobalVars
# on some of the lections Sergey Sergienco said that u can use global variables on such projects
$rapers = []
# rubocop:enable Style/GlobalVars

# This method smells of :reek:UtilityFunction
# I think it will be better to paste this code here in couse of small project
def find_rapers
  rapers_names_only ||= begin
    rapers_names_only = []
    Dir.chdir('texts') do
      Dir.glob('*против*').each do |title|
        rapers_names_only << title.split(' против').first.strip
      end
    end
    rapers_names_only.uniq
  end
end

# rubocop:disable Style/GlobalVars
def analize_by_obscenity(top_bad_words)
  find_rapers.each { |file| $rapers << Raper.add_raper(file) }
  $rapers.sort_by!(&:bad_in_round).reverse!
  show_top_rapers($rapers, top_bad_words)
end
# rubocop:enable Style/GlobalVars

def show_top_rapers(rapers, top_bad_words)
  rows = []
  top_bad_words.to_i.times { |name_of_participant| rows << get_participant_as_row(rapers[name_of_participant]) }
  table = Terminal::Table.new rows: rows
  puts table
end

# This method smells of :reek:UtilityFunction
# I think it will be better to paste this code here in couse of small project
def get_participant_as_row(raper)
  row = [raper.name, "#{raper.battles} батлов"]
  row += ["#{raper.bad_words} нецензурных слов"]
  row += ["#{raper.bad_in_round} слов на батл"]
  row + ["#{raper.words_in_round} слов в раунде"]
end

opts = Trollop.options { opt :top_bad_word, 'Number of top', default: 5 }

analize_by_obscenity(opts[:top_bad_word])
