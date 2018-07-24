require 'trollop' # Trollop is a commandline option parser for Ruby
require 'russian_obscenity' # Gem for filtering russian obscene language
require 'terminal-table' # Ruby ASCII Table Generator
require './utils' # Utility functions
require './data_loader'

opts = Trollop.options do
  opt %s[top-bad-words], 'Prints <i> records from the Top Bad Words', default: 0
  # opt %s[top-words], 'Prints <i> words per people or list rappers if run without --name', :default => 30
  # opt :name, 'Name of the rapper. Use with --top-words', :type => :string
end

# rules for ARGV parametrs
# Trollop::educate if ARGV.empty?
Trollop.die %s[top-bad-words], 'must be non-negative' if opts[%s[top-bad-words]] <= 0
# p opts

class Report
  def print
    raise NotImplementedError
  end
end

# :reek:Attribute
class TopBadWordsReport < Report
  attr_writer :top_bad_words

  def initialize(top_bad_words)
    @top_bad_words = top_bad_words
  end

  def print
    print_top_bad_words(@top_bad_words)
  end

  private

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def print_top_bad_words(top_bad_words)
    btl_words = %w[батл батла батлов]
    cenz1_words = %w[нецензурное нецензурных нецензурных]
    cenz2_words = %w[слово слова слов]
    data_sort = DataLoader.new.load_data.sort_by { |hsh| hsh[:words_per_battle] }.reverse[0...top_bad_words]
    data_sort.each_with_index do |hsh, itr|
      # rubocop:disable Metrics/LineLength
      data_sort[itr][:battles_count] = "#{hsh[:battles_count]} #{Utils.declension_words(hsh[:battles_count], btl_words)}"
      data_sort[itr][:bad_words_count] = "#{hsh[:bad_words_count]} #{Utils.declension_words(hsh[:bad_words_count], cenz1_words)} #{Utils.declension_words(hsh[:bad_words_count], cenz2_words)}"
      data_sort[itr][:words_per_battle] = "#{hsh[:words_per_battle]} #{Utils.declension_words(hsh[:words_per_battle], cenz2_words)} на батл"
      data_sort[itr][:words_per_stage] = "#{hsh[:words_per_stage]} #{Utils.declension_words(hsh[:words_per_stage], cenz2_words)} в раунде"
      # rubocop:enable Metrics/LineLength
    end
    rows = []
    top_bad_words.times do |itr|
      # rubocop:disable Metrics/LineLength
      rows << [data_sort[itr][:name], data_sort[itr][:battles_count], data_sort[itr][:bad_words_count], data_sort[itr][:words_per_battle], data_sort[itr][:words_per_stage]]
      # rubocop:enable Metrics/LineLength
    end
    table = Terminal::Table.new do |tbl|
      tbl.rows = rows
      tbl.style = { border_top: false, border_bottom: false }
    end
    puts table
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end

TopBadWordsReport.new(opts[%s[top-bad-words]]).print
