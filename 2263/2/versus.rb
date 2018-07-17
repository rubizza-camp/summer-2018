require_relative 'args_parser'
require_relative 'analyzer'

class TopBadWordsOrganizer
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(battles_analyzer, words_analyzer, number)
    @battles_analyzer = battles_analyzer
    @words_analyzer = words_analyzer
    @number = number
  end

  def calculate
    words = @words_analyzer.words
    bad_words = @words_analyzer.bad_words
    battles = @battles_analyzer.battles
    rounds = @battles_analyzer.rounds
    organize(words, bad_words, battles, rounds)
  end

  private

  def organize(words, bad_words, battles, rounds)
    list = {}
    bad_words.each do |name, bad_words_number|
      list.merge!(name => { battles: battles[name],
                            bad_words: bad_words_number,
                            bad_words_per_battle: bad_words_number.fdiv(battles[name]),
                            words_per_round: words[name].fdiv(rounds[name]) })
    end
    list = sort(list)
    delete_excess(list)
  end

  def sort(list)
    list = list.sort_by { |element| element[1][:bad_words_per_battle] }
    list.reverse.to_h
  end

  def delete_excess(list)
    counter = 0
    list.delete_if { (counter += 1) > number }
    list
  end
end

class TopWordsOrganizer < TopBadWordsOrganizer
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(each_word_analyzer, number)
    @each_word_analyzer = each_word_analyzer
    @number = number
  end

  def calculate
    list = @each_word_analyzer.each_word
    organize(list)
  end

  private

  def organize(list)
    disabled_words_list = scan_dictionary
    list.each do |name, words_hash|
      list[name] = sort(words_hash, disabled_words_list)
      list[name] = delete_excess(list[name])
    end
  end

  def scan_dictionary
    disabled_words_list = []
    dictionary = File.open('disabled_words_dictionary')
    dictionary.each { |word| disabled_words_list << word.match(/.*(?=\n)/).to_s }
    disabled_words_list
  end

  def sort(words_hash, disabled_words_list)
    words_hash.delete_if { |word| disabled_words_list.include?(word.to_s) }
    words_hash = words_hash.sort_by { |element| element[1] }
    words_hash.reverse.to_h
  end
end

class TopBadWordsPrinter
  def print_result(list)
    print_border
    list.each do |name, info|
      printf("| %-25s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
             name.to_s + ':', info[:battles], info[:bad_words], info[:bad_words_per_battle], info[:words_per_round])
    end
    print_border
  end

  private

  def print_border
    print '+---------------------------+------------+-------------------'
    print "---+------------------------------+--------------------------+\n"
  end
end

class TopWordsPrinter
  def print_result(list)
    list.each do |name, words_hash|
      print_border
      printf("| %-29s |\n", name.to_s + ':')
      print_border
      print_core(words_hash)
    end
    print_border
  end

  private

  def print_border
    puts '+-------------------------------+'
  end

  def print_core(words_hash)
    words_hash.each { |word, num| printf("| %-15s - %3d times   |\n", word, num) }
  end
end

class DefaultOptions
  def top_bad_words(option)
    top_bad_words = 5 if option == :default
    top_bad_words = option.to_i if option.class == String
    top_bad_words
  end

  def top_words(option)
    top_words = 30 if option == :default
    top_words = option.to_i if option.class == String
    top_words
  end
end

def print_unknown_name(name)
  puts "I don't know MC #{name}, but I know these:"
  battles.each_key { |each_name| puts each_name }
  exit
end

def print_unknown_action(name)
  puts "I know MC #{name}, but I don't know what to do with it. Use --help to see all options"
  exit
end

begin
  args_parser = ArgsParser.new
  options = args_parser.options
  Help.new.show_help if options[:help]
  top_bad_words = DefaultOptions.new.top_bad_words(options[:top_bad_words])
  top_words = DefaultOptions.new.top_words(options[:top_words])
  name = options[:name]
  if name
    battles = BattlesAnalyzer.new.battles
    print_unknown_name(name) unless battles.key?(name.to_sym)
    print_unknown_action(name) if !top_bad_words && !top_words
  end
  if top_bad_words
    battles_analyzer = BattlesAnalyzer.new(name)
    words_analyzer = WordsAnalyzer.new(name)
    list = TopBadWordsOrganizer.new(battles_analyzer, words_analyzer, top_bad_words).calculate
    TopBadWordsPrinter.new.print_result(list)
  end
  if top_words
    each_word_analyzer = EachWordAnalyzer.new(name)
    list = TopWordsOrganizer.new(each_word_analyzer, top_words).calculate
    TopWordsPrinter.new.print_result(list)
  end
rescue AnalyzerTextNameError => exeption
  exeption.show_message
end
