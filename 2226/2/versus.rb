require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
# :reek:RepeatedConditional
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:UtilityFunction
# :reek:FeatureEnvy
# rubocop:disable Metrics/ClassLength
class Raper
  SWEAR_WORDS_ARRAY = [
    'блять', 'блядь', 'бляди', 'ебать', 'ёб', 'бля', 'блядина', 'блядский', 'блядистость', 'блядогон',
    'блядословник', 'блядский', 'блядство', 'въебаться', 'взбляд', 'впиздячил', 'выблядовал', 'выблядок',
    'выебон', 'выёбывается', 'глупизди', 'доебался', 'ебанёшься', 'ебанул', 'ебашит', 'ёбнул', 'ебало',
    'ебанулся', 'ебнул', 'жидоёб', 'жидоёбский', 'заёб', 'изъебнулся', 'заебал', 'заебись', 'козлоёб',
    'козлоёбище', 'хуй', 'пизда', 'пиздец', '\*', 'сука'
  ].freeze

  SWEAR_WORDS = SWEAR_WORDS_ARRAY.join('|')

  def filter_rapers_from_the_list(file_name)
    first_filter = file_name.sub(/ротив_/, '')
    second_filter = first_filter.sub(/_\(.*/, '')
    third_filter = second_filter.sub(%r/^rap-battles\/_/, '')
    third_filter.sub(/_$/, '')
  end

  def list_all_rapers
    raper_storage = []

    Dir.glob('rap-battles/*') do |file_name|
      filtered_data = filter_rapers_from_the_list(file_name)
      raper_storage << filtered_data.split('_п')
      raper_storage.flatten!.uniq!
    end
    raper_storage
  end

  def number_of_battles(name)
    battles_storage = [1]

    Dir.glob('rap-battles/*') do |file_name|
      battles_storage << file_name.match(name)
      battles_storage.reject!(&:nil?)
    end
    battles_storage.size / 2
  end

  def number_of_swear_words(name)
    swear_words_storage = []

    Dir.glob('rap-battles/*') do |file_name|
      if file_name.match(name)
        text = File.read(file_name)
        swear_words_storage << text.scan(/#{SWEAR_WORDS}/)
        swear_words_storage.flatten!
      end
    end
    swear_words_storage.size
  end

  def average_number_swearing_words_in_battle(name)
    average = number_of_swear_words(name).fdiv(number_of_battles(name))
    average.round(2)
  end

  def number_of_words_in_rounds(name)
    number_of_words_in_rounds = 0

    Dir.glob('rap-battles/*') do |file_name|
      if file_name.match(name)
        text = File.read(file_name)
        number_of_words_in_rounds += text.split(' ').length
      end
    end
    number_of_words_in_rounds
  end

  def number_of_rounds(name)
    round_words = []

    Dir.glob('rap-battles/*') do |file_name|
      if file_name.match(name)
        text = File.read(file_name)
        round_words << text.match(/Раунд/)
        round_words.reject!(&:nil?)
      end
    end
    round_words
  end

  def average_number_words_in_round(name)
    number_of_rounds = number_of_rounds(name).size
    number_of_rounds = 1 if number_of_rounds.zero?

    number_of_words_in_rounds(name) / number_of_rounds
  end

  def sort_and_reverse_hash(hash_for_sorting, sorted_storage)
    hash_for_sorting = hash_for_sorting.sort_by { |_key, value| value[1] }
    hash_for_sorting.reverse!
    hash_for_sorting.each do |elem|
      sorted_storage[elem[0]] = elem[1]
    end
    sorted_storage
  end

  def statistics(number)
    unsorted_storage = {}
    sorted_storage = {}
    list_all_rapers.each do |raper|
      storage_for_each_raper = []
      storage_for_each_raper << number_of_battles(raper) << number_of_swear_words(raper)
      storage_for_each_raper << average_number_swearing_words_in_battle(raper) << average_number_words_in_round(raper)
      unsorted_storage[raper] = storage_for_each_raper
    end
    sorted_storage = sort_and_reverse_hash(unsorted_storage, sorted_storage)
    sorted_storage.first(number.to_i)
  end

  # rubocop:disable Metrics/AbcSize
  def make_table(number)
    filtered_data = {}
    statistics(number).each do |elem|
      filtered_data[elem[0]] = elem[1]
    end
    rows = []
    filtered_data.each do |k, v|
      rows << [k.to_s, v[0].to_s + ' баттлов', v[1].to_s + ' нецензурных слов',
               v[2].to_s + ' слова на баттл', v[3].to_s + ' слова в раунде']
    end
    Terminal::Table.new rows: rows
  end
  # rubocop:enable Metrics/AbcSize

  def count_all_duplicates(array_storage)
    array_storage.each_with_object(Hash.new(0)) { |word, counts| counts[word] += 1 }
  end

  def storage_for_all_text(name)
    text_storage = ''
    if list_all_rapers.include? name
      Dir.glob('rap-battles/*') do |file_name|
        if file_name.match(name)
          text = File.read(file_name)
          text_storage += text
        end
      end
    end
    text_storage
  end

  def the_most_used_words(top_words, name)
    array_storage = storage_for_all_text(name).gsub(/,|'/, ' ').split.reject! { |x| x.length < 4 }
    array_storage.map(&:capitalize!)
    hash_storage = count_all_duplicates(array_storage)
    hash_storage = hash_storage.sort_by { |_key, value| value }.reverse.to_h
    hash_storage.first(top_words.to_i)
  end

  # rubocop:disable Metrics/AbcSize
  def print_top_words(top_words, name)
    if list_all_rapers.include? name
      the_most_used_words(top_words, name).each do |elem|
        puts elem[0].to_s + ' - ' + elem[1].to_s + ' раз'
      end
    else
      puts "Репер #{name} не известен мне. Зато мне известны: "
      puts list_all_rapers
    end
  end
  # rubocop:enable Metrics/AbcSize
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
