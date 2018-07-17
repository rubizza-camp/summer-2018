require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
require 'russian'
require 'yaml'

# This class is used for storing data
class DataStorage
  def self.show_all_data
    Dir.glob('rap-battles/*').each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end

  def self.list_all_rapers
    filter_rapers.flatten.uniq
  end

  def self.filter_rapers_from_the_list(file_name)
    filter = file_name.sub(/ротив_/, '').sub(/_\(.*/, '')
    filter.sub(%r/^rap-battles\/_/, '').sub(/_$/, '')
  end

  def self.filter_rapers
    show_all_data.inject([]) do |array, (file_name, _file_content)|
      filtered_data = filter_rapers_from_the_list(file_name).split('_п')
      array << filtered_data
    end
  end
end

# This class is used for single raper methods
class Raper
  SWEAR_WORDS = YAML.load_file('config.yml')['SWEAR_WORDS_ARRAY'].join('|')

  def self.avg_number_of_battles(name)
    DataStorage.show_all_data.inject(0) do |counter, (file_name, _file_content)|
      counter + file_name.scan(name).size
    end
  end

  def self.number_of_battles(name)
    avg_number_of_battles(name) / 2
  end

  def self.number_of_swear_words(name)
    real_name = name
    DataStorage.show_all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.scan(/#{SWEAR_WORDS}/).size if file_name.match(real_name)
      counter
    end
  end

  def self.average_number_swearing_words_in_battle(name)
    average = number_of_swear_words(name).fdiv(number_of_battles(name))
    average.round(2)
  end

  def self.number_of_words_in_rounds(name)
    DataStorage.show_all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.split(/\W/).size if file_name.match(name)
      counter
    end
  end

  def self.number_of_rounds(name)
    DataStorage.show_all_data.inject(1) do |counter, (file_name, file_content)|
      counter += file_content.scan(/Раунд \w/).size if file_name.match(name)
      counter
    end
  end

  def self.average_number_words_in_round(name)
    number_of_words_in_rounds(name) / number_of_rounds(name)
  end
end

# :reek:FeatureEnvy # ridiculous warning, basic terminal-table config offer such code
# This class is used for printing table to the terminal
class PrintTable
  def initialize(top_bad_words)
    @top_bad_words = top_bad_words
    puts make_table(@top_bad_words)
  end

  def statistics(number_of_rapers)
    sort_and_reverse_hash(PrintTable.sort_storage).first(number_of_rapers.to_i).map { |elem| [elem[0], elem[1]] }.to_h
  end

  def self.sort_storage
    DataStorage.list_all_rapers.each_with_object({}) do |raper, hash|
      hash[raper] = [
        Raper.number_of_battles(raper), Raper.number_of_swear_words(raper),
        Raper.average_number_swearing_words_in_battle(raper), Raper.average_number_words_in_round(raper)
      ]
    end
  end

  # :reek:DuplicateMethodCall # ridiculous warning
  def make_table(number_of_rapers)
    rows = []
    statistics(number_of_rapers).each do |key, value|
      rows << [key.to_s,
               "#{value[0]} #{Russian.p(value[0], 'баттл', 'баттла', 'баттлов')}",
               "#{value[1]} нецензурных слов",
               "#{value[2]} слова на баттл",
               "#{value[3]} слова в раунде"]
    end
    Terminal::Table.new(rows: rows)
  end

  private

  # :reek:UtilityFunction
  def sort_and_reverse_hash(hash_for_sorting)
    hash_for_sorting = hash_for_sorting.sort_by { |_, value| value [1] }
    hash_for_sorting.reverse!
    hash_for_sorting.map { |elem| [elem[0], elem[1]] }.to_h
  end
end

# This class print top words to the terminal
class PrintTopWords
  PRONOUNS = YAML.load_file('config.yml')['PRONOUNS_ARRAY'].join('|')

  def initialize(top_words, name)
    @top_words = top_words
    @name = name
    print_top_words(@top_words, @name)
  end

  # :reek:DuplicateMethodCall
  def print_top_words(top_words, name)
    if DataStorage.list_all_rapers.include?(name)
      the_most_used_words(top_words, name).each do |elem|
        puts "#{elem[0]} - #{elem[1]} #{Russian.p(elem[1], 'раз', 'раза', 'раз')}"
      end
    else
      puts "Репер #{name} не известен мне. Зато мне известны: "
      puts DataStorage.list_all_rapers
    end
  end

  private

  # :reek:UtilityFunction
  def count_all_duplicates(array_storage)
    array_storage.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  # :reek:UtilityFunction
  def storage_for_all_text(name)
    DataStorage.show_all_data.inject('') do |string, (file_name, file_content)|
      string += file_content if file_name.match(name)
      string
    end
  end

  def the_most_used_words(top_words, name)
    array_storage = storage_for_all_text(name).gsub(/,|'/, ' ').split
    array_storage.delete_if { |elem| elem.match(/#{PRONOUNS}/) }.map!(&:capitalize)
    count_all_duplicates(array_storage).sort_by { |_, value| value }.reverse.to_h.first(top_words.to_i)
  end
end

options = { 'top-bad-words' => nil, 'top-words' => 30, 'name' => nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Use help for that programm'
  opts.on('-bad-words', '--top-bad-words=number', 'Enter number of rapers you want to see') do |number|
    options['top-bad-words'] = number
  end

  opts.on('-top-words', '--top-words=number', 'Enter number of top words you want to see') do |number|
    options['top-words'] = number
  end

  opts.on('-n', '--name=name', 'Enter name of the raper you want to see') do |name|
    options['name'] = name
  end

  opts.on('-h', '--help', 'Use this option for more info') do
    puts opts
    exit
  end
end

parser.parse!

PrintTable.new(options['top-bad-words']) unless options['top-bad-words'].nil?

PrintTopWords.new(options['top-words'], options['name']) unless options['name'].nil?
