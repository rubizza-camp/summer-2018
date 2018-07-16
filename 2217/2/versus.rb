# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/PerceivedComplexity

require 'rake'
require 'russian_obscenity'
require 'optparse'
require 'terminal-table'

RAPPERS_NAMES = {
  '13/47' => '13/47',
  '1917' => '1917',
  'Артема Лоика' => 'Артем Лоик',
  'Басоты' => 'Басота',
  'Вити Classic' => 'Витя Classic',
  'Витя CLassic' => 'Витя Classic',
  "Вити Classic'a" => 'Витя Classic',
  'Galata' => 'galat',
  'галат' => 'galat',
  'галата' => 'galat',
  'Галата' => 'galat',
  'Galat' => 'galat',
  'Слава КПСС' => 'Гнойный',
  'Соня Мармеладова' => 'Гнойный',
  'Хип-хоп одинокой старухи' => 'ХХОС',
  'ГИГА' => 'Giga 1',
  'John rai' => 'Jonh Rai',
  'Jubille' => 'Jubilee',
  'Noiza MC' => 'Noize MC',
  'tvoigreh' => 'Tvoigreh',
  'Дуни' => 'Дуня',
  'Замая' => 'Замай',
  'Ильи Мирный' =>  'Илья Мирный',
  'Ильи Мирного' => 'Илья Мирный',
  'MoonStara' => 'MoonStar'
}.freeze

@names = Array.new(0)

# This method smells of :reek:DuplicateMethodCall and :reek:TooManyStatements
# This method smells of :reek:NestedIterators and :reek:UtilityFunction
def exclude_repeated_names(names)
  tmp = []
  names.each do |first_name|
    names.each do |second_name|
      if first_name.size != second_name.size && (first_name.include?(second_name) || second_name.include?(first_name))
        tmp = first_name.size > second_name.size ? first_name : second_name
        names.delete(tmp) if tmp
      end
    end
  end
  names.delete(tmp) if tmp
  names.sort.uniq!
  RAPPERS_NAMES.each_key do |key|
    next unless names.any?(key)
    names[names.index(key)] = RAPPERS_NAMES[key]
    names[names.index(key)] = RAPPERS_NAMES[key] if names.index(key)
  end
  names.sort.uniq!
end

# This method smells of :reek:FeatureEnvy
def get_all_names(filename)
  return filename[0, filename.index('&')].strip! if filename.include?('&')

  if filename.include?('против')
    filename[0, filename.index('против')].strip!
  elsif filename.include?('vs')
    filename[0, filename.index('vs')].strip!
  elsif filename.include?('VS')
    filename[0, filename.index('VS')].strip!
  else
    puts 'Что-то пошло не так.'
  end
end

# This method smells of :reek:TooManyStatements and :reek:UtilityFunction
# This method smells of :reek:NestedIterators
def count_bad_words(name)
  counts = []
  filelist = FileList.new('*против*', '*vs*', '*VS*')
  filelist.exclude('*.rb')
  filelist.each do |filename|
    next unless filename.include?(name)
    file = File.open(filename)
    words = file.read
    bad_words = words.downcase.tr(',.?&quot;!', '').split(' ').select { |word| word.match(/[а-яА-Я]+[*][а-я]+/) || RussianObscenity.obscene?(word) }
    counts << bad_words
  end
  counts.flatten.count
end

def average_bad_words(name)
  (count_bad_words(name) / find_battles(name).to_f).round(2)
end

# This method smells of :reek:TooManyStatements and :reek:UtilityFunction
def find_average_round_words(name)
  battle_texts = []
  words_count = 0
  Dir.glob('*[^.rb]') do |filename|
    if filename.match?(name)
      text = File.read(filename)
      battle_texts << text
    end
  end
  battle_texts.each do |battle|
    words_count += battle.split.count
  end
  words_count / (battle_texts.count * 3)
end

# This method smells of :reek]:TooManyStatements and :reek:UtilityFunction
# This method smells of :reek:TooManyStatements
def find_battles(name)
  all_battles = []

  Dir.glob('*[^.rb]') do |filename|
    battle = filename.match(name)
    all_battles << battle
    all_battles.reject!(&:nil?)
  end
  all_battles.count
end

all_names = []

filelist = FileList.new('*против*', '*vs*', '*VS*')
filelist.exclude('*.rb')
filelist.each { |filename| all_names << get_all_names(filename) }
@names = exclude_repeated_names(all_names)

def battle_hash
  hash = @names.each_with_object(Hash.new(0)) do |rapper, total_bad_words|
    rapper = rapper
    total_bad_words[rapper] += count_bad_words(rapper)
  end
  hash.sort_by { |_rapper, total_bad_words| total_bad_words }
end

OptionParser.new do |options|
  options.on('--top-bad-words=') do |number|
    table = Terminal::Table.new do |terminal|
      rapper_name = battle_hash.reverse[0...number.to_i].to_h
      rapper_name.each do |rapper, bad_words|
        terminal << [rapper, "#{find_battles(rapper)} батлов", "#{bad_words} нецензурных слов",
                     "#{average_bad_words(rapper)} слов на баттл", "#{find_average_round_words(rapper)} слов в раунде"]
      end
    end
    puts table
  end
end.parse!
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/PerceivedComplexity
