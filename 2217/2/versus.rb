require 'rake'
require 'russian_obscenity'
require 'optparse'
require 'terminal-table'

RAPPERS_NAMES = {
  'Billy Milligan' => ["Billy Milligan'а"],
  'Galat' => ["Galat'a", 'Галат', 'Галата', 'Galata'],
  'Giga 1' => ['ГИГА'],
  'MoonStar' => ['MoonStara'],
  'John Rai' => ['John rai'],
  'Johnyboy' => ["Johnyboy'a"],
  'Noize MC' => ['Noiza MC'],
  'Jubilee' => ['Jubille'],
  'Oxxxymiron' => ["Oxxxymiron'a", 'Oxxxymirona'],
  'Tvoigreh' => ['tvoigreh'],
  'Артем Лоик' => ['Артема Лоика', 'Лоика'],
  'Басота' => ['Басоты'],
  'Букер' => ['Букера'],
  'Гарри Топор' => ['Гарри Топора'],
  'Гнойный' => ['Соня Мармеладова aka Гнойный', 'Гнойный aka Слава КПСС'],
  'Дуня' => ['Дуни'],
  'ХХОС' => ['Хип-хоп одинокой старухи'],
  'Замай' => ['Замая'],
  'Илья Мирный' => ['Ильи Мирного', 'Ильи Мирный'],
  'Витя Classic' => ["Вити Classic'a", 'Витя CLassic', 'Вити Classic']
}.freeze

def rapper_list_check
  array = collect_all_names
  for key in RAPPERS_NAMES.keys
    RAPPERS_NAMES[key].each do |hash_key|
      array.each do |array_item|
        array[array.index(hash_key)] = key if hash_key == array_item
      end
    end
  end
  array.sort.uniq!
end

def file_name_check
  array = []
  FileList.new('*против*', '*vs*', '*VS*').exclude('*.rb').each do |filename|
    array <<
      if filename.include?('против')
        filename.include?('aka') ? filename[0, filename.index('aka')].strip! : filename[0, filename.index('против')].strip!
      elsif filename.include?('VS')
        filename[0, filename.index('VS')].strip!
      elsif filename.include?('vs')
        filename[0, filename.index('vs')].strip!
      end
  end
  array.sort.uniq!
end

def collect_all_names
  file_name_check
end

def count_bad_words(name)
  counts = []
  FileList.new('*против*', '*vs*', '*VS*').exclude('*.rb').each do |filename|
    next unless filename.include?(name)
    counts << File.read(filename)
                  .downcase.tr(',.?&quot;!', '')
                  .split(' ')
                  .select { |word| word.match(/[а-яА-Я]+[*][а-я]+/) || RussianObscenity.obscene?(word) }
  end
  counts.flatten.count
end

def average_bad_words(name)
  (count_bad_words(name) / find_battles(name).to_f).round(2)
end

def find_average_round_words(name)
  battle_texts = []
  words_count = 0
  Dir.glob('*[^.rb]') { |filename| battle_texts << File.read(filename) if filename.match?(name) }
  battle_texts.each { |battle| words_count += battle.split.count }
  words_count / (battle_texts.count * 3)
end

def find_battles(name)
  all_battles = []
  Dir.glob('*[^.rb]') do |filename|
    all_battles << filename.match(name)
    all_battles.reject!(&:nil?)
  end
  all_battles.count
end

@names = rapper_list_check
p @names

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
        terminal << [rapper,
                     "#{find_battles(rapper)} батлов",
                     "#{bad_words} нецензурных слов",
                     "#{average_bad_words(rapper)} слов на баттл",
                     "#{find_average_round_words(rapper)} слов в раунде"]
      end
    end
    puts table
  end
end.parse!
