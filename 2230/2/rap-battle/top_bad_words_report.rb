require './data_loader'
require './report'

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

  def declension_dict
    [%w[батл батла батлов], %w[нецензурное нецензурных нецензурных], %w[слово слова слов]]
  end

  # rubocop:disable Metrics/AbcSize
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def fill_table(data)
    words = declension_dict
    data.each_with_index do |hsh, itr|
      # rubocop:disable Metrics/LineLength
      data[itr][:battles_count] = "#{hsh[:battles_count]} #{Utils.declension_words(hsh[:battles_count], words[0])}"
      data[itr][:bad_words_count] = "#{hsh[:bad_words_count]} #{Utils.declension_words(hsh[:bad_words_count], words[1])} #{Utils.declension_words(hsh[:bad_words_count], words[2])}"
      data[itr][:words_per_battle] = "#{hsh[:words_per_battle]} #{Utils.declension_words(hsh[:words_per_battle], words[2])} на батл"
      data[itr][:words_per_stage] = "#{hsh[:words_per_stage]} #{Utils.declension_words(hsh[:words_per_stage], words[2])} в раунде"
      # rubocop:enable Metrics/LineLength
    end
  end
  # rubocop:enable Metrics/AbcSize

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def print_table(data)
    str = data.map { |hsh| hsh.values_at(:name, :battles_count, :bad_words_count, :words_per_battle, :words_per_stage) }
    table = Terminal::Table.new do |tbl|
      tbl.rows = str
      tbl.style = { border_top: false, border_bottom: false }
    end
    puts table
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def print_top_bad_words(top_bad_words)
    data_sort = DataLoader.new.load_data.sort_by { |hsh| hsh[:words_per_battle] }.reverse.first(top_bad_words)
    result_table = fill_table(data_sort)
    print_table(result_table)
  end
end
