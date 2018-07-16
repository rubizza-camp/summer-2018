require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
require 'russian'
require_relative 'config'
# :reek:RepeatedConditional
# :reek:TooManyStatements
# :reek:UtilityFunction
# :reek:FeatureEnvy
# :reek:TooManyMethods
# :reek:DuplicateMethodCall
# rubocop:disable Metrics/ClassLength
class Raper
  PRONOUNS = PRONOUNS_ARRAY.join('|')

  SWEAR_WORDS = SWEAR_WORDS_ARRAY.join('|')

  def all_data_storage
    Dir.glob('rap-battles/*').each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end

  def list_all_rapers
    filter_rapers.flatten.uniq
  end

  def avg_number_of_battles(name)
    all_data_storage.inject(0) do |counter, (file_name, _file_content)|
      counter += file_name.scan(name).size
      counter
    end
  end

  def number_of_battles(name)
    avg_number_of_battles(name) / 2
  end

  def number_of_swear_words(name)
    all_data_storage.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.scan(/#{SWEAR_WORDS}/).size if file_name.match(name)
      counter
    end
  end

  def average_number_swearing_words_in_battle(name)
    average = number_of_swear_words(name).fdiv(number_of_battles(name))
    average.round(2)
  end

  def number_of_words_in_rounds(name)
    all_data_storage.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.split(/\W/).size if file_name.match(name)
      counter
    end
  end

  def number_of_rounds(name)
    all_data_storage.inject(1) do |counter, (file_name, file_content)|
      counter += file_content.scan(/Раунд \w/).size if file_name.match(name)
      counter
    end
  end

  def average_number_words_in_round(name)
    number_of_words_in_rounds(name) / number_of_rounds(name)
  end

  def statistics(number_of_rapers)
    unsorted_storage = {}
    list_all_rapers.each do |raper|
      unsorted_storage[raper] = [
        number_of_battles(raper), number_of_swear_words(raper),
        average_number_swearing_words_in_battle(raper), average_number_words_in_round(raper)
      ]
    end
    sorted_storage = sort_and_reverse_hash(unsorted_storage)
    sorted_storage.first(number_of_rapers.to_i).map { |elem| [elem[0], elem[1]] }.to_h
  end

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

  def print_top_words(top_words, name)
    if list_all_rapers.include?(name)
      the_most_used_words(top_words, name).each do |elem|
        puts "#{elem[0]} - #{elem[1]} #{Russian.p(elem[1], 'раз', 'раза', 'раз')}"
      end
    else
      puts "Репер #{name} не известен мне. Зато мне известны: "
      puts list_all_rapers
    end
  end

  private

  def filter_rapers_from_the_list(file_name)
    filter = file_name.sub(/ротив_/, '').sub(/_\(.*/, '')
    filter.sub(%r/^rap-battles\/_/, '').sub(/_$/, '')
  end

  def filter_rapers
    all_data_storage.inject([]) do |array, (file_name, _file_content)|
      filtered_data = filter_rapers_from_the_list(file_name).split('_п')
      array << filtered_data
    end
  end

  def sort_and_reverse_hash(hash_for_sorting)
    hash_for_sorting = hash_for_sorting.sort_by { |_, value| value [1] }
    hash_for_sorting.reverse!
    hash_for_sorting.map { |elem| [elem[0], elem[1]] }.to_h
  end

  def count_all_duplicates(array_storage)
    array_storage.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  def storage_for_all_text(name)
    all_data_storage.inject('') do |string, (file_name, file_content)|
      string += file_content if file_name.match(name)
      string
    end
  end

  def the_most_used_words(top_words, name)
    array_storage = storage_for_all_text(name).gsub(/,|'/, ' ').split
    array_storage.delete_if { |elem| elem.match(/#{PRONOUNS}/) }.map!(&:capitalize)
    hash_storage = count_all_duplicates(array_storage)
    hash_storage = hash_storage.sort_by { |_, value| value }.reverse.to_h
    hash_storage.first(top_words.to_i)
  end
end
# rubocop:enable Metrics/ClassLength

options = { 'top-bad-words' => nil, 'top-words' => 30, 'name' => nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Info for all options'
  opts.on('-bad-words', '--top-bad-words=number', 'Yeap, its top-bad-words') do |number|
    options['top-bad-words'] = number
  end

  opts.on('-top-words', '--top-words=number', 'Yeap, its top-words') do |number|
    options['top-words'] = number
  end

  opts.on('name', '--name=name', 'Yeap, its name') do |name|
    options['name'] = name
  end
end

parser.parse!

puts Raper.new.make_table(options['top-bad-words']) unless options['top-bad-words'].nil?

Raper.new.print_top_words(options['top-words'], options['name']) unless options['name'].nil?
