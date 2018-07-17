require 'active_support/inflector'
require 'russian'
require 'json'
require 'russian_obscenity'
require './battle'
# This method smells of :reek:TooManyInstanceVariables
class Raper
  FILE_BAD_WORDS       = 'bad_words.json'.freeze
  FILE_PRONOUNS        = 'pronouns.json'.freeze
  DICTIONARY_BAD_WORDS = JSON.parse(File.read(FILE_BAD_WORDS))
  PRONOUNS             = JSON.parse(File.read(FILE_PRONOUNS))

  attr_reader :name, :rap_files
  attr_reader :count_words_in_round, :bad_words, :count_rounds, :favorite_words

  def initialize(name, files = '')
    @name                 = name
    @rap_files            = files
    @bad_words            = []
    @count_rounds         = 0
    @count_words_in_round = 0
    @favorite_words       = Hash.new(0)
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
    fetch_count_rounds
  end

  def self.raper?(raper)
    !Dir.glob("#{Battle::FOLDER}/*#{raper}*").size.zero?
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

  def fetch_files
    @rap_files = Dir.glob("#{Battle::FOLDER}/*#{name}*").reject do |file|
      File.directory? file
    end
  end

  def self.all
    obj_rapers = []
    Battle.new.rapers_all.each do |name, files|
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
    arr_words = clearing_text_from_garbage(text)
    @count_words_in_round += arr_words.size
    arr_words.map!(&:downcase)
    counting_favorite_words(arr_words)
    handling_bad_words(arr_words)
  end

  # This method smells of :reek:UtilityFunction
  def clearing_text_from_garbage(text)
    arr_words = text.delete(",.!?\"\':;«»").split(' ')
    arr_words = arr_words.select! { |word| word.size > 3 }
    arr_words - PRONOUNS
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

  def fetch_count_rounds
    rap_files.each do |file|
      value = File.read(file).split(/Раунд\s[0-9]\./).size
      value.zero? ? 1 : value - 1
      @count_rounds += value
    end
  end
end
