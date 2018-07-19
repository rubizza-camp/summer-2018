# Class that initializes with hash of {:name => rapper_obj} form and prints it in required form
class Printer
  attr_reader :rappers_hash

  def initialize(rappers_hash)
    @rappers_hash = check_rappers_hash(rappers_hash)
  end

  def top_rude_rappers(number = nil)
    sorted_hash = sort_obscene_words
    cleaned_hash = pick_first(sorted_hash, number)
    print_top_rude_rappers(cleaned_hash)
  end

  def top_words(number = nil, dictionary_file = nil)
    dictionary = dictionary_file ? scan_dictionary(dictionary_file) : nil
    sorted_hash = sort_top_words
    cleaned_hash = clean_top_words(sorted_hash, number, dictionary)
    print_top_words(cleaned_hash)
  end

  private

  def check_rappers_hash(hash)
    raise(PrinterListError, hash) if hash.class != Hash || hash.values.any? { |value| value.class != Rapper }
    hash
  end

  def sort_obscene_words
    @rappers_hash.sort_by { |pair| -pair[1].obscene_words_per_battle }.to_h
  end

  def sort_top_words
    @rappers_hash.each_with_object({}) do |(name, rapper_obj), hash|
      hash[name] = rapper_obj.unique_words.sort_by { |word, number| -number }.to_h
    end
  end

  def pick_first(hash, number)
    counter = 0
    hash.delete_if { (counter += 1) > number } if number
    hash
  end

  def clean_top_words(hash, number, dictionary)
    hash.each do |name, words_hash|
      hash[name] = clean_with_dictionary(words_hash, dictionary) if dictionary
      hash[name] = pick_first(words_hash, number)
    end
  end

  def clean_with_dictionary(hash, dictionary)
    hash.delete_if { |word| dictionary.include?(word.to_s) }
  end

  def check_file(file)
    file.class == File ? file : raise(PrinterFileError, file)
  end

  def scan_dictionary(dictionary_file)
    check_file(dictionary_file)
    dictionary = []
    dictionary_file.each { |word| dictionary << word.match(/.*(?=\n)/).to_s }
    dictionary
  end

  def print_top_rude_rappers(rappers_hash)
    print_rude_rappers_border
    rappers_hash.each do |name, obj|
      printf("| %-26s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
             name.to_s + ':', obj.number_of_battles, obj.number_of_obscene_words,
             obj.obscene_words_per_battle, obj.words_per_round)
    end
    print_rude_rappers_border
  end

  def print_rude_rappers_border
    print '+----------------------------+------------+-------------------'
    print "---+------------------------------+--------------------------+\n"
  end

  def print_top_words(rappers_hash)
    rappers_hash.each do |name, words_hash|
      print_words_name(name)
      words_hash.each { |word, num| printf("| %-15s | %3d times   |\n", word, num) }
    end
    print_words_border
  end

  def print_words_name(name)
    print_words_border
    printf("| %-29s |\n", name.to_s + ':')
    print_words_border
  end

  def print_words_border
    puts '+-----------------+-------------+'
  end
end

# Exception, that is raised when dictionary file given to Printer#top_words is not a File object
class PrinterFileError < StandardError
  def initialize(file, message = nil)
    @file = file
    @message = message ? default_message : message
  end

  private

  def default_message
    "Error. #{@file} is not a File object"
  end
end
