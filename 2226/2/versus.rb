require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
# :reek:RepeatedConditional
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:UtilityFunction
# :reek:FeatureEnvy
# :reek:TooManyMethods
# rubocop:disable Metrics/ClassLength
class Raper
  SWEAR_WORDS_ARRAY = %w[
    блять блядь бляди ебать ёб бля блядина блядский блядистость блядогон
    блядословник блядский блядство въебаться взбляд впиздячил выблядовал выблядок
    выебон выёбывается глупизди доебался ебанёшься ебанул ебашит ёбнул ебало
    ебанулся ебнул жидоёб жидоёбский заёб изъебнулся заебал заебись козлоёб
    козлоёбище хуй пизда пиздец \* сука
  ].freeze

  PRONOUNS_ARRAY = %w[
    ты Ты и И я Я в не Не что на но с как это а А Но У он Он - – Так У у За за Эй
    то по бы тебе мой же его мы от ведь Ведь где Где про к В до чем еще о без Мы —  
  ].freeze

  PRONOUNS = PRONOUNS_ARRAY.join('|')

  SWEAR_WORDS = SWEAR_WORDS_ARRAY.join('|')

  def all_data_storage
    Dir.glob('rap-battles/*').each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end

  def list_all_rapers
    filter_rapers.flatten!.uniq!
  end

  # :reek:DuplicateMethodCall
  def number_of_battles(name)
    battles_storage = []

    all_data_storage.each do |file|
      battles_storage << file.first.match(name)
      battles_storage.reject!(&:nil?)
    end
    battles_storage << 'at least one battle' if battles_storage.size.zero?

    battles_storage.size / 2
  end

  def number_of_swear_words(name)
    swear_words_storage = []

    all_data_storage.inject([]) do |_, file|
      if file.first.match(name)
        swear_words_storage << file.last.scan(/#{SWEAR_WORDS}/)
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

    all_data_storage.inject([]) do |_, file|
      number_of_words_in_rounds += file.last.split(/\W/).count if file.first.match(name)
    end
    number_of_words_in_rounds
  end

  # :reek:DuplicateMethodCall
  def number_of_rounds(name)
    round_words = []

    all_data_storage.inject([]) do |_, file|
      if file.first.match(name)
        round_words << file.last.match(/Раунд \w/)
        round_words.reject!(&:nil?)
      end
    end
    round_words << 'this raper had at least 1 round' if round_words.size.zero?

    round_words.size
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
    sorted_storage.first(number_of_rapers.to_i)
  end

  def make_table(number_of_rapers)
    filtered_data = statistics(number_of_rapers).map { |elem| [elem[0], elem[1]] }.to_h
    rows = []
    filtered_data.each do |k, v|
      rows << [
        k.to_s, "#{v[0]} баттлов", "#{v[1]} нецензурных слов",
        "#{v[2]} слова на баттл", "#{v[3]} слова в раунде"
      ]
    end
    Terminal::Table.new rows: rows
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

  private

  def filter_rapers_from_the_list(file_name)
    filter = file_name.sub(/ротив_/, '').sub(/_\(.*/, '')
    filter.sub(%r/^rap-battles\/_/, '').sub(/_$/, '')
  end

  def filter_rapers
    all_data_storage.inject([]) do |array, file|
      filtered_data = filter_rapers_from_the_list(file.first)
      array << filtered_data.split('_п')
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
    text_storage = ''
    if list_all_rapers.include?(name)
      all_data_storage.inject([]) do |_, file|
        text_storage += file.last if file.first.match(name)
      end
    end
    text_storage
  end

  def the_most_used_words(top_words, name)
    array_storage = storage_for_all_text(name).gsub(/,|'/, ' ').split
    array_storage.delete_if { |x| x.match(/#{PRONOUNS}/) }.map!(&:capitalize)
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
