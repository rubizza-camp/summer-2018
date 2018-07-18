require 'active_support/inflector'
require 'russian'
require 'json'
require 'russian_obscenity'
require './data_rapers'
require './count_rounds'

class Raper
  include RoundDataCollection
  FILE_BAD_WORDS       = 'bad_words.json'.freeze
  DICTIONARY_BAD_WORDS = JSON.parse(File.read(FILE_BAD_WORDS))

  attr_reader :name, :rap_files
  attr_reader :bad_words, :favorite_words

  def initialize(name, files = '')
    @name                 = name
    @rap_files            = files
    @bad_words            = []
    @favorite_words       = Hash.new(0)
  end

  def count_rounds
    fetch_data_rounds(rap_files)[:count_rounds]
  end

  def count_words_in_round
    fetch_data_rounds(rap_files)[:count_words]
  end

  def avg_words_battle
    averaged = (bad_words.size / 1.0 / rap_files.size).round(2)
    sugar = Russian.p(averaged, 'слово', 'слова', 'слов', 'слов')
    averaged = averaged.to_s
    "#{averaged.ljust(6)} #{sugar} на баттл".ljust(25)
  end

  def avg_words_rounds
    avg_words = (count_words_in_round / 1.0 / count_rounds).round(2)
    sugar = Russian.p(avg_words, 'слово', 'слова', 'слов', 'слов')
    format('%6s ', avg_words) + " #{sugar} в раунде"
  end

  def stats
    fetch_bad_words
  end

  def self.raper?(raper)
    !Dir.glob("#{DataRapers::Battle::FOLDER}/*#{raper}*").size.zero?
  end

  def show
    word_batl     = Russian.p(rap_files.size, 'баттл', 'баттла', 'баттлов')
    foul_lang     = Russian.p(bad_words.size, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов')
    col_two = "#{rap_files.size.to_s.ljust(3)} #{word_batl}"
    col_three = "#{format('%3s ', bad_words.size)} #{foul_lang}"
    result_show(col_two, col_three)
  end

  def result_show(col_two, col_three)
    col_one = name.ljust(25)
    col_two = col_two.ljust(12)
    "#{col_one} | #{col_two} | #{col_three} | #{avg_words_battle} | #{avg_words_rounds}"
  end

  def show_favorite_words(before_n = 30)
    stats
    arr = favorite_words.sort_by { |_word, counter| 1 - counter }[0...before_n]
    arr.each { |key, value| puts "#{key} - #{value}" }
  end

  def fetch_files_one_raper
    @rap_files = Dir.glob("#{DataRapers::Battle::FOLDER}/*#{name}*").reject do |file|
      File.directory? file
    end
  end

  def self.all
    obj_rapers = []
    DataRapers::Battle.new.rapers_all.each do |name, files|
      obj_rapers.push(Raper.new(name, files))
      obj_rapers[obj_rapers.size - 1].stats
    end
    obj_rapers
  end

  private

  def fetch_bad_words
    rap_files.each do |file|
      text = File.read(file)
      handling_text(text)
    end
  end

  # This method smells of :reek:FeatureEnvy
  def handling_text(text)
    arr_words = DataRapers::Battle.clearing_text_from_garbage(text)
    arr_words.map!(&:downcase)
    counting_favorite_words(arr_words)
    handling_bad_words(arr_words)
  end

  def counting_favorite_words(arr_words)
    arr_words.each { |word| @favorite_words[word] += 1 }
  end

  def handling_bad_words(arr_words)
    arr_words.select! { |str| check_bad_words(str) }
    @bad_words |= arr_words.uniq
  end

  # This method smells of :reek:UtilityFunction
  def check_bad_words(str)
    str =~ /\*/ || RussianObscenity.obscene?(str) ||
      DICTIONARY_BAD_WORDS.include?(str)
  end
end
