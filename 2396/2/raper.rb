require 'active_support/inflector'
require 'russian'
require 'json'
require 'russian_obscenity'
require './battle'
# This method smells of :reek:TooManyInstanceVariables:
class Raper
  FILE_BAD_WORDS       = 'bad_words.json'.freeze
  FILE_PRONOUNS        = 'pronouns.json'.freeze
  DICTIONARY_BAD_WORDS = JSON.parse(File.read(FILE_BAD_WORDS))
  PRONOUNS             = JSON.parse(File.read(FILE_PRONOUNS))
  # This method smells of :reek:Attribute
  attr_accessor :name, :rap_files
  # This method smells of :reek:Attribute
  attr_accessor :count_words_in_round, :bad_words, :count_rounds, :favorite_words

  def initialize(name, files = '')
    @name                 = name
    @rap_files            = files
    @bad_words            = []
    @count_rounds         = 0
    @count_words_in_round = 0
    @favorite_words       = Hash.new(0)
  end

  def size_bad_words
    bad_words.size
  end

  def count_batl
    rap_files.size
  end

  def avg_words_battle
    averaged = (size_bad_words / 1.0 / count_batl).round(2)
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

  # This method smells of :reek:TooManyStatements
  def show
    word_batl     = Russian.p(count_batl, 'баттл', 'баттла', 'баттлов')
    foul_lang     = Russian.p(size_bad_words, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов')
    col_one = name.ljust(25)
    col_two = "#{count_batl.to_s.ljust(3)} #{word_batl}".ljust(12)
    col_three = "#{format('%3s ', size_bad_words)} #{foul_lang}"
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

  # This method smells of :reek:TooManyStatements
  def self.all
    rapers = Battle.new.rapers_all
    obj_rapers = []
    index = 0
    rapers.each do |rap, info|
      obj_rapers[index] = Raper.new(rap, info)
      obj_rapers[index].stats
      index += 1
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
  # This method smells of :reek:TooManyStatements
  def handling_text(text)
    arr_words = text.delete(",.!?\"\':;«»").split(' ')
    arr_words.select! { |word| word.size > 3 }
    self.count_words_in_round += arr_words.size
    arr_words.map!(&:downcase)
    arr_words -= PRONOUNS
    arr_words.each { |word| favorite_words[word] += 1 }
    handling_bad_words(arr_words)
  end

  def handling_bad_words(arr_words)
    arr_words.select! { |str| check_bad_words(str) }
    self.bad_words |= arr_words.uniq
  end

  def check_bad_words(str)
    str =~ /\*/ || RussianObscenity.obscene?(str) ||
      DICTIONARY_BAD_WORDS.include?(str)
  end

  # This method smells of :reek:TooManyStatements
  def fetch_count_rounds
    rap_files.each do |file|
      text = File.read(file)
      value = text.split(/Раунд\s[0-9]\./).size
      value.zero? ? 1 : value - 1
      self.count_rounds += value
    end
  end
end
