require 'forwardable'

# Class that initializes with hash of {:name => rapper_obj} form and Printer object.
# Leads data to the required form and prints it
class Handler
  attr_reader :rappers_hash, :printer

  def initialize(rappers_hash, printer)
    @rappers_hash = check_rappers_hash(rappers_hash)
    @printer = check_printer(printer)
  end

  extend Forwardable
  def_delegator :@printer, :print_top_rude_rappers
  def_delegator :@printer, :print_top_words

  def top_rude_rappers(number = nil)
    sorted_hash = sort_obscene_words
    cleaned_hash = sorted_hash.take(number)
    print_top_rude_rappers(cleaned_hash)
  end

  def top_words(number = nil, dictionary_file = nil)
    sorted_hash = @rappers_hash.reduce({}) { |hash, (name, rapper)| hash.merge(name => rapper.unique_words_sorted) }
    cleaned_hash = TopWordsCleaner.new(sorted_hash, number, dictionary_file).clean
    print_top_words(cleaned_hash)
  end

  private

  def check_rappers_hash(hash)
    hash.values.any? { |value| !value.is_a?(Rapper) } ? raise(VersusExceptions::VersusObjectError, hash) : hash
  end

  def check_printer(printer)
    printer.is_a?(Printer) ? printer : raise(VersusExceptions::VersusObjectError, printer)
  end

  def check_file(file)
    file.is_a?(File) ? file : raise(VersusExceptions::VersusFileError, file)
  end

  def sort_obscene_words
    @rappers_hash.sort_by { |_name, rapper| -rapper.obscene_words_per_battle }.to_h
  end

  def clean_top_words(hash, number, dictionary_file)
    dictionary = dictionary_file ? scan_dictionary(dictionary_file) : nil
    hash.each do |name, words_hash|
      hash[name] = clean_with_dictionary(words_hash, dictionary).take(number) if dictionary
    end
  end
end

# Class, that cleans top_words with dictionary and taks some first values
class TopWordsCleaner
  def initialize(hash, number = nil, dictionary_file = nil)
    @hash = hash
    @number = number
    @dictionary_file = dictionary_file
  end

  def clean
    dictionary = @dictionary_file ? scan_dictionary : nil
    @hash.each_key do |name|
      clean_with_dictionary(name, dictionary) if dictionary
      @hash[name] = @hash[name].take(@number) if @number
    end
  end

  private

  def check_dictionary
    @dictionary_file.is_a?(File) ? @dictionary_file : raise(VersusExceptions::VersusFileError, @dictionary_file)
  end

  def scan_dictionary
    check_dictionary.map { |word| word.split("\n") }.flatten
  end

  def clean_with_dictionary(name, dictionary)
    @hash[name].delete_if { |word| dictionary.include?(word.to_s) }
  end
end
