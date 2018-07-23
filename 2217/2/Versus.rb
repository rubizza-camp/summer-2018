require 'rake'
require 'russian'
require 'russian_obscenity'
require 'optparse'
require_relative 'Pronomens'

# rappers name synonyms
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

# module Versus
module Versus
  def self.rapper_list_check(name, array)
    array.product(RAPPERS_NAMES[name]) do |rapper_name, synonym|
      next unless synonym == rapper_name
      array[array.index(rapper_name)] = name
    end
    array
  end

  def self.rapper_list(list_of_names)
    RAPPERS_NAMES.each_key do |name|
      rapper_list_check(name, list_of_names)
    end
    list_of_names.sort.uniq
  end

  def self.file_name_check(file)
    file.split(/ против | vs | VS /)[0]
  end

  def self.collect_all_files
    Dir.pwd
    Dir.chdir('rap_battles')
    Dir.glob('*').to_a
  end

  @files = collect_all_files

  def self.collect_all_names
    array = []
    @files.each do |filename|
      array <<  file_name_check(filename.strip)
    end
    array.sort.uniq
  end

  def self.name_check_condition(filename, name)
    file_name_check(filename.strip) == name
  end

  def self.bad_words_filter(filename)
    File.read(filename)
        .downcase.tr(',.?&quot;!', '')
        .split(' ')
        .select { |word| word.match(/[а-яА-Я]+[*][а-я]+/) || RussianObscenity.obscene?(word) }
  end

  def self.count_bad_words(name)
    counts = []
    @files.each do |filename|
      next unless name_check_condition(filename, name)
      counts << bad_words_filter(filename)
    end
    counts.flatten.count
  end

  def self.top_word_filter(filename)
    File.read(filename)
        .downcase.tr('–,.?&quot;!', '')
        .split(' ')
        .select { |word| word.match(/S*/) && !Pronomens.exclude_pronomens(word) }
        .group_by { |word| word }
        .map { |key, value| [key, value.size] }
        .sort_by { |___, key| -key }
  end

  def self.count_top_words(name)
    counts = {}
    @files.each do |filename|
      next unless name_check_condition(filename, name)
      counts = top_word_filter(filename)
    end
    counts
  end

  def self.average_bad_words(name)
    (count_bad_words(name) / count_battles(name).to_f).round(2)
  end

  def self.collect_all_texts(name)
    battle_texts = []
    @files.each do |filename|
      next unless name_check_condition(filename, name)
      battle_texts << File.read(filename) if File.exist?(filename)
    end
    battle_texts
  end

  def self.count_rounds(name)
    rounds = 1
    collect_all_texts(name).each do |text|
      rounds += text.scan(/[Р|р]аунд [1|2|3]/).count
    end
    rounds
  end

  def self.count_all_words(name)
    words_count = 0
    collect_all_texts(name).each do |battle|
      words_count += battle.split.count
    end
    words_count
  end

  def self.find_average_round_words(name)
    count_all_words(name) / (count_rounds(name) * collect_all_texts(name).count)
  end

  def self.count_battles(name)
    all_battles = []
    @files.each do |filename|
      next unless name_check_condition(filename, name)
      all_battles << filename
    end
    all_battles.compact.count
  end
end
