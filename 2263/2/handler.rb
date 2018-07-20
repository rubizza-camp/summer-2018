require 'forwardable'

# Class that initializes with hash of {:name => rapper_obj} form and Printer object.
# Leads data to the required form and prints it
class Handler
  attr_reader :rappers_hash

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
    sorted_hash = @rappers_hash.reduce({}) { |memo, (name, obj)| sort_words(name, obj, memo) }
    cleaned_hash = clean_top_words(sorted_hash, number, dictionary_file)
    print_top_words(cleaned_hash)
  end

  private

  def check_rappers_hash(hash)
    hash.values.any? { |value| value.class != Rapper } ? raise(HandlerObjectError, hash) : hash
  end

  def check_printer(printer)
    printer.class == Printer ? printer : raise(HandlerObjectError, printer)
  end

  def sort_obscene_words
    @rappers_hash.sort_by { |pair| -pair[1].obscene_words_per_battle }.to_h
  end

  def sort_words(name, rapper_obj, hash)
    hash[name] = rapper_obj.unique_words.sort_by { |_word, number| -number }.to_h
    hash
  end

  def clean_top_words(hash, number, dictionary_file)
    dictionary = dictionary_file ? scan_dictionary(dictionary_file) : nil
    hash.each do |name, words_hash|
      hash[name] = clean_with_dictionary(words_hash, dictionary) if dictionary
      hash[name] = words_hash.take(number)
    end
  end

  def clean_with_dictionary(hash, dictionary)
    hash.delete_if { |word| dictionary.include?(word.to_s) }
  end

  def check_file(file)
    file.is_a?(File) ? file : raise(HandlerFileError, file)
  end

  def scan_dictionary(dictionary_file)
    check_file(dictionary_file)
    dictionary_file.map { |word| word.split("\n") }.flatten
  end
end

# Exception, that is raised when dictionary file given to Handlerr#top_words is not a File object
class HandlerFileError < StandardError
  def initialize(file, message = nil)
    @file = file
    @message = message || default_message
  end

  private

  def default_message
    "Error. #{@file} is not a File object"
  end
end

# Exception, that is raised when Handler argument is not an object of require classes
class HandlerObjectError < StandardError
  def initialize(obj, message = nil)
    @obj = obj
    @message = message || default_message
  end

  private

  def default_message
    "Error. #{@obj} is not is not an object of require classes"
  end
end
