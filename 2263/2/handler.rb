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
    cleaned_hash = clean_top_words(sorted_hash, number, dictionary_file)
    print_top_words(cleaned_hash)
  end

  private

  def check_rappers_hash(hash)
    hash.values.any? { |value| !value.is_a?(Rapper) } ? raise(HandlerObjectError, hash) : hash
  end

  def check_printer(printer)
    printer.is_a?(Printer) ? printer : raise(HandlerObjectError, printer)
  end

  def check_file(file)
    file.is_a?(File) ? file : raise(HandlerFileError, file)
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

  def scan_dictionary(dictionary_file)
    check_file(dictionary_file)
    dictionary_file.map { |word| word.split("\n") }.flatten
  end

  def clean_with_dictionary(hash, dictionary)
    hash.delete_if { |word| dictionary.include?(word.to_s) }
  end
end

# Exception, that is raised when dictionary file given to Handlerr#top_words is not a File object
class HandlerFileError < StandardError
  def initialize(file, message = default_message)
    @file = file
    @message = message
  end

  private

  def default_message
    "Error. given object is not a File"
  end
end

# Exception, that is raised when Handler argument is not an object of require classes
class HandlerObjectError < StandardError
  def initialize(obj, message = default_message)
    @obj = obj
    @message = message
  end

  private

  def default_message
    "Error. given object is not is not an object of require classes"
  end
end
