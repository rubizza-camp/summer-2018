require 'trollop' # Trollop is a commandline option parser for Ruby
require 'russian_obscenity' # Gem for filtering russian obscene language
require './utils' # Utility functions

opts = Trollop.options do
  opt %s[top-bad-words], 'Prints <i> records from the Top Bad Words', default: 0
  # opt %s[top-words], 'Prints <i> words per people or list rappers if run without --name', :default => 30
  # opt :name, 'Name of the rapper. Use with --top-words', :type => :string
end

# rules for ARGV parametrs
# Trollop::educate if ARGV.empty?
Trollop.die %s[top-bad-words], 'must be non-negative' if opts[%s[top-bad-words]] <= 0
# p opts

class FileReader
  attr_reader :content

  def initialize
    @content = ''
  end

  def read(files)
    @content = get_all_text(files)
  end

  # :reek:FeatureEnvy
  # :reek:NestedIterators
  # :reek:TooManyStatements
  def get_all_text(files)
    content = ''
    files.each do |file_name|
      fh = open "data/#{file_name.gsub(/:[()"'*.-]/) { |sym| '\\' + sym }.chomp}"
      content += fh.read

      fh.close
    end
    content
  end
end

class DataLoader
  attr_reader :data

  def initialize
    @data = [] # public
    @rapper_names = [] # private
  end

  def load_data
    @rapper_names = load_rapper_names
    @data = build_data
  end

  private

  def load_rapper_names
    fh = open 'config/rapper_names'
    fh.map(&:rstrip)
  end

  # Generate list of files
  # rubocop:disable Style/InverseMethods
  def build_file_list(folder)
    Dir.entries(folder).select { |file_name| !File.directory? file_name }
  end
  # rubocop:enable Style/InverseMethods

  # parse list of files
  # :reek:TooManyStatements
  def get_file_list(name)
    common_file_list = build_file_list('data')
    file_list = []
    # filter rapper names by name
    names = Utils.escape_string(@rapper_names.grep(/#{Utils.escape_string(name)}/)[0].gsub(', ', '|'))
    common_file_list.grep(/#{names}/i).each do |file_name|
      file_list << "#{file_name}\n" if file_name.sub(/\s(прот|vs|VS ).+/, '').index(/#{names}/)
    end
    file_list
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # :reek:TooManyStatements
  def build_data
    @rapper_names.each do |rapper_name|
      rapper_name = rapper_name.sub(/,.*/, '')

      files = get_file_list(rapper_name)
      text = FileReader.new.read(files)
      battles_count = files.size
      words_count = text.scan(/\S+/).size
      bad_words_count = RussianObscenity.find(text).size
      words_per_battle = (bad_words_count.fdiv battles_count).round(2)
      words_per_stage = ((words_count.fdiv battles_count).fdiv 3).round(0)
      # rubocop:disable Metrics/LineLength
      data << { name: rapper_name, text: text, battles_count: battles_count, words_count: words_count, bad_words_count: bad_words_count, words_per_battle: words_per_battle, words_per_stage: words_per_stage }
      # rubocop:enable Metrics/LineLength
    end
    data
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end

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
    col4_size = data_sort[0][:words_per_battle].size + 1
    col1_size = data_sort.sort_by { |hsh| hsh[:name] }.reverse[0][:name].size + 1
    col2_size = data_sort.sort_by { |hsh| hsh[:battles_count] }.reverse[0][:battles_count].size + 1
    col3_size = data_sort.sort_by { |hsh| hsh[:bad_words_count] }.reverse[0][:bad_words_count].size + 1
    # col4_size = data_sort.sort_by { |hsh| hsh[:words_per_battle] }.reverse[0][:words_per_battle].size + 1
    col5_size = data_sort.sort_by { |hsh| hsh[:words_per_stage] }.reverse[0][:words_per_stage].size + 1
    top_bad_words.times do |itr|
      # rubocop:disable Metrics/LineLength
      puts "#{data_sort[itr][:name].ljust(col1_size)}| #{data_sort[itr][:battles_count].ljust(col2_size)}| #{data_sort[itr][:bad_words_count].ljust(col3_size)}| #{data_sort[itr][:words_per_battle].ljust(col4_size)}| #{data_sort[itr][:words_per_stage].ljust(col5_size)}|"
      # rubocop:enable Metrics/LineLength
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end

TopBadWordsReport.new(opts[%s[top-bad-words]]).print
