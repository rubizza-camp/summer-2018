require 'rake'
require 'russian'
require 'russian_obscenity'
require 'optparse'
require 'terminal-table'

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
      array[array.index(rapper_name)] = name if synonym == rapper_name
    end
    array
  end

  def self.rapper_list(list_of_names)
    RAPPERS_NAMES.each_key { |name| rapper_list_check(name, list_of_names) }
    list_of_names.sort.uniq!
  end

  def self.file_name_check(filename)
    filename[0, filename.index(/ против | vs | VS /)] if filename.match?(/ против | vs | VS /)
  end

  def self.collect_all_files
    FileList.new('*против*', '*vs*', '*VS*').exclude('*.rb')
  end

  def self.collect_all_names
    array = []
    collect_all_files.each do |filename|
      array <<  file_name_check(filename.strip!)
    end
    array.sort.uniq!
  end

  def self.bad_words_filter(filename)
    File.read(filename)
        .downcase.tr(',.?&quot;!', '')
        .split(' ')
        .select { |word| word.match(/[а-яА-Я]+[*][а-я]+/) || RussianObscenity.obscene?(word) }
  end

  def self.count_bad_words(name)
    counts = []
    collect_all_files.each do |filename|
      next unless filename.include?(name)
      counts << bad_words_filter(filename)
    end
    counts.flatten.count
  end

  def self.average_bad_words(name)
    (count_bad_words(name) / find_battles(name).to_f).round(2)
  end

  def self.collect_all_texts(name)
    battle_texts = []
    collect_all_files.each { |filename| battle_texts << File.read(filename) if filename.match?(name) }
    battle_texts
  end

  def self.count_all_words(name)
    words_count = 0
    collect_all_texts(name).each { |battle| words_count += battle.split.count }
    words_count
  end

  def self.find_average_round_words(name)
    count_all_words(name) / (collect_all_texts(name).count * 3)
  end

  def self.find_battles(name)
    all_battles = []
    collect_all_files.each { |filename| all_battles << filename.match(name) }
    all_battles.compact.count
  end

  def self.battle_hash
    hash = rapper_list(collect_all_names).each_with_object(Hash.new(0)) do |rapper, total_bad_words|
      rapper = rapper
      total_bad_words[rapper] += count_bad_words(rapper)
    end
    hash.sort_by { |_rapper, total_bad_words| total_bad_words }
  end

  def self.syntax_output(number)
    return Russian.p(number, 'слово', 'слова', 'слов', 'слова') if number.class == Float
    Russian.p(number, 'слово', 'слова', 'слов')
  end

  def self.output_table(name, bad_words)
    average_bad_words = average_bad_words(name)
    average_round_words = find_average_round_words(name)
    find_battles = find_battles(name)
    [name,
     "#{find_battles} #{Russian.p(find_battles, 'батл', 'батла', 'батлов')}",
     "#{bad_words} нецензурных #{syntax_output(bad_words)}",
     "#{average_bad_words} #{syntax_output(average_bad_words)} на батл",
     "#{average_round_words} #{syntax_output(average_round_words)} в раунде"]
  end
end
