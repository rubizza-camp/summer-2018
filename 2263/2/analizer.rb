require 'russian_obscenity'
require 'active_support/all'

# rubocop:disable Metrics/ClassLength
# Class for analizyng versus battles
class Analyzer
  attr_reader :paths

  def initialize(path = __dir__ + '/texts')
    @paths = Dir[path + '/*'] # Path to directory with texts
  end

  def path=(new_path)
    raise AnalizerArgumentError, new_path unless new_path.respond_to?(:to_s)
    @paths = Dir[new_path.to_s + '/*']
  end

  # :reek:TooManyStatements
  def words(name = nil)
    list = {}
    @paths.each do |path|
      name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s # Name pattern
      raise AnalizerTextNameError, path if name_in_file == ''
      if !name || name_in_file == name
        list = add_entry(name_in_file, count_words(path), list)
      end
    end
    list
  end

  # :reek:TooManyStatements
  def bad_words(name = nil)
    list = {}
    @paths.each do |path|
      name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
      raise AnalizerTextNameError, path if name_in_file == ''
      if !name || name_in_file == name
        list = add_entry(name_in_file, count_bad_words(path), list)
      end
    end
    list
  end

  # :reek:TooManyStatements
  def rounds(name = nil)
    list = {}
    @paths.each do |path|
      name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
      raise AnalizerTextNameError, path if name_in_file == ''
      if !name || name_in_file == name
        list = add_entry(name_in_file, count_rounds(path), list)
      end
    end
    list
  end

  # :reek:TooManyStatements
  def battles(name = nil)
    list = {}
    @paths.each do |path|
      name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
      raise AnalizerTextNameError, path if name_in_file == ''
      list = add_entry(name_in_file, 1, list) if !name || name_in_file == name
    end
    list
  end

  # :reek:TooManyStatements
  def all_words(name = nil)
    list = {}
    @paths.each do |path|
      name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
      raise AnalizerTextNameError, path if name_in_file == ''
      if !name || name_in_file == name
        list = add_entry_all_words(name_in_file, count_all_words(path), list)
      end
    end
    list
  end

  private

  # :reek:TooManyStatements
  def count_words(path)
    words_counter = 0
    file = File.open(path)
    file.each do |line|
      words = line.split(/[^[[:word:]]\*]+/)
      next if round_check(words)
      words_counter += words.size
    end
    words_counter
  end

  # :reek:TooManyStatements
  def count_bad_words(path)
    bad_words_counter = 0
    file = File.open(path)
    file.each do |line|
      words = line.split(/[^[[:word:]]\*]+/)
      next if round_check(words)
      words.each do |word|
        bad_words_counter += 1 if RussianObscenity.obscene?(word) || word.match(/.*\*.*/)
      end
    end
    bad_words_counter
  end

  # :reek:TooManyStatements
  def count_rounds(path)
    rounds_counter = 0
    file = File.open(path)
    file.each do |line|
      words = line.split(/[^[[:word:]]\*]+/)
      rounds_counter += 1 if round_check(words)
    end
    rounds_counter.zero? ? 1 : rounds_counter
  end

  # :reek:TooManyStatements
  def count_all_words(path)
    all_words = {}
    file = File.open(path)
    file.each do |line|
      words = line.split(/[^[[:word:]]\*]+/)
      next if round_check(words)
      words.each do |word|
        all_words.key?(to_lower(word).to_sym) ? all_words[word] += 1 : all_words[word] = 1
      end
    end
    all_words
  end

  # :reek:TooManyStatements
  def add_entry(name, number, list)
    name = name.to_sym
    if list.key?(name)
      list[name] += number
    else
      list[name] = number
    end
    list
  end

  def add_entry_all_words(name, all_words, list)
    name = name.to_sym
    list[name] = list.key?(name) ? merge_with_sum(list[name], all_words) : all_words
    list
  end

  # :reek:TooManyStatements
  def merge_with_sum(first_hash, second_hash)
    second_hash.each_key do |key|
      if first_hash.key?(key)
        first_hash[key] += second_hash[key]
      else
        first_hash.merge(key => second_hash[key])
      end
    end
    first_hash
  end

  # Check if it's round description line
  def round_check(words)
    if !words[1].to_i.zero? && words[0] =~ /(Р|р)аунд/
      true
    elsif !words[0].to_i.zero? && words[1] =~ /(Р|р)аунд/
      true
    else
      false
    end
  end

  # Downcase russian symbols
  def to_lower(word)
    word.mb_chars.downcase!.to_s
  end
end
# rubocop:enable Metrics/ClassLength

# Exception that is raised if text file doesn't match pattern
class AnalizerTextNameError < StandardError
  def initialize(path)
    @file = path
  end

  def show_message
    puts "Error. Name of #{@file} doesn't match to pattern (<name> VS/Против)"
  end
end

# Exception that is raised if new analizer path can't be translated to string
class AnalizerArgumentError < StandardError
  def initialize(path)
    @path = path
  end

  def show_message
    puts "Error. Object #{@path} doesn't respond to method to_s."
  end
end
