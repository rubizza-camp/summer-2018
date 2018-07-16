require 'russian_obscenity'
require 'active_support/all'

# Class for analizyng versus battles
class Analyzer
  attr_reader :paths

  def initialize(path = __dir__ + '/texts')
    @paths = Dir[path + '/*'] # Path to directory with texts convertes to array of paths to each file
    @list = {}
  end

  def path=(new_path)
    raise AnalyzerArgumentError, new_path unless new_path.respond_to?(:to_s)
    @paths = Dir[new_path.to_s + '/*']
  end

  def words(name = nil)
    @list = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      explore_file(name_in_file) { count_words(path) } if !name || name_in_file == name
    end
    @list
  end

  def bad_words(name = nil)
    @list = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      explore_file(name_in_file) { count_bad_words(path) } if !name || name_in_file == name
    end
    @list
  end

  def rounds(name = nil)
    @list = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      explore_file(name_in_file) { count_rounds(path) } if !name || name_in_file == name
    end
    @list
  end

  def battles(name = nil)
    @list = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      add_entry_to_list(name_in_file, 1) if !name || name_in_file == name
    end
    @list
  end

  private

  def get_name_in_file(path)
    name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
    raise AnalyzerTextNameError, path if name_in_file == ''
    name_in_file
  end

  def explore_file(name_in_file)
    words_number = yield
    add_entry_to_list(name_in_file, words_number)
  end

  def count_words(path)
    words_counter = 0
    file = File.open(path)
    file.each do |line|
      words = to_word_array(line)
      next if round_description?(words)
      words_counter += words.size
    end
    words_counter
  end

  def count_bad_words(path)
    bad_words_counter = 0
    file = File.open(path)
    file.each do |line|
      words = to_word_array(line)
      next if round_description?(words)
      bad_words_counter = check_obscenity(words, bad_words_counter)
    end
    bad_words_counter
  end

  def check_obscenity(words, counter)
    words.each do |word|
      counter += 1 if RussianObscenity.obscene?(word) || word.match(/.*\*.*/)
    end
    counter
  end

  def count_rounds(path)
    rounds_counter = 0
    file = File.open(path)
    file.each do |line|
      words = to_word_array(line)
      rounds_counter += 1 if round_description?(words)
    end
    rounds_counter.zero? ? 1 : rounds_counter
  end

  def to_word_array(line)
    words = line.split(/[^[[:word:]]\*]+/)
    words
  end

  def add_entry_to_list(name, number)
    name = name.to_sym
    @list[name] = @list.key?(name) ? @list[name] + number : number
  end

  def round_description?(words)
    return true if !words[1].to_i.zero? && words[0] =~ /(Р|р)аунд/
    return true if !words[0].to_i.zero? && words[1] =~ /(Р|р)аунд/
    false
  end
end

# Class for making hash of each word if file
class AnalyzerEachWord < Analyzer
  def initialize(path = __dir__ + '/texts')
    @paths = Dir[path + '/*'] # Path to directory with texts convertes to array of paths to each file
    @list = {}
    @words_hash = {}
  end

  def each_word(name = nil)
    @list = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      explore_file(path, name_in_file) if !name || name_in_file == name
    end
    @list
  end

  private

  def add_entry_to_list(name, words_hash)
    name = name.to_sym
    @list[name] = @list.key?(name) ? merge_with_sum(@list[name], words_hash) : words_hash
  end

  def merge_with_sum(first_hash, second_hash)
    second_hash.each_key do |key|
      first_hash.key?(key) ? first_hash[key] += second_hash[key] : first_hash.merge(key => second_hash[key])
    end
    first_hash
  end

  def handle_word_array(words)
    words.each do |word|
      word = to_lower(word).to_sym
      @words_hash[word] = @words_hash.key?(word) ? @words_hash[word] + 1 : 1
    end
  end

  def count_each_word(path)
    @words_hash = {}
    file = File.open(path)
    file.each do |line|
      words = to_word_array(line)
      next if round_description?(words)
      handle_word_array(words)
    end
    @words_hash
  end

  def explore_file(path, name)
    words_hash = count_each_word(path)
    add_entry_to_list(name, words_hash)
  end

  # Downcase russian symbols
  def to_lower(word)
    word.mb_chars.downcase!.to_s
  end
end

# Exception that is raised if text file doesn't match pattern
class AnalyzerTextNameError < StandardError
  def initialize(path)
    @file = path
  end

  def show_message
    puts "Error. Name of #{@file} doesn't match to pattern (<name> VS/Против)"
  end
end

# Exception that is raised if new analizer path can't be translated to string
class AnalyzerArgumentError < StandardError
  def initialize(path)
    @path = path
  end

  def show_message
    puts "Error. Object #{@path} doesn't respond to method to_s."
  end
end
