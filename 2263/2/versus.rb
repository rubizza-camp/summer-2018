require_relative 'args_parser'
require_relative 'analyzer'

class TopBadWordsOutput
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(battles_analyzer, words_analyzer, number, name = nil)
    @battles_analyzer = battles_analyzer
    @words_analyzer = words_analyzer
    @number = number
    @name = name
    @list = {}
  end

  def calculate
    @list = {}
    words = @words_analyzer.words(@name)
    bad_words = @words_analyzer.bad_words(@name)
    battles = @battles_analyzer.battles(@name)
    rounds = @battles_analyzer.rounds(@name)
    organize(words, bad_words, battles, rounds)
  end

  def print_result
    print_border
    @list.each do |name, info|
      printf("| %-25s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
             name.to_s + ':', info[:battles], info[:bad_words], info[:bad_words_per_battle], info[:words_per_round])
    end
    print_border
  end

  private

  def organize(words, bad_words, battles, rounds)
    bad_words.each do |name, bad_words_number|
      @list.merge!(name => { battles: battles[name],
                            bad_words: bad_words_number,
                            bad_words_per_battle: bad_words_number.fdiv(battles[name]),
                            words_per_round: words[name].fdiv(rounds[name]) })
    end
    sort
    @list = delete_excess(@list)
  end

  def sort
    @list = @list.sort_by { |element| element[1][:bad_words_per_battle] }
    @list = @list.reverse.to_h
  end

  def delete_excess(list)
    counter = 0
    list.delete_if { (counter += 1) > number }
    list
  end

  def print_border
    print '+---------------------------+------------+-------------------'
    print "---+------------------------------+--------------------------+\n"
  end
end

class TopWordsOutput < TopBadWordsOutput
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(each_word_analyzer, number, name = nil)
    @each_word_analyzer = each_word_analyzer
    @number = number
    @name = name
    @list = {}
  end

  def calculate
    @list = {}
    @list = @each_word_analyzer.each_word(name)
    organize
  end

  def print_result
    @list.each do |name, words_hash|
      print_border
      printf("| %-29s |\n", name.to_s + ':')
      print_border
      words_hash.each { |word, num| printf("| %-15s - %3d times   |\n", word, num) }
    end
    print_border
  end
  
  private

  def organize
    disabled_words_list = scan_dictionary
    @list.each do |name, words_hash|
      @list[name] = sort(words_hash, disabled_words_list)
      @list[name] = delete_excess(@list[name])
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
    words_hash = words_hash.reverse.to_h
    words_hash
  end

  def print_border
    puts '+-------------------------------+'
  end
end

def set_top_bad_words(option)
  top_bad_words = 5 if option == :default
  top_bad_words = option.to_i if option.class == String
  top_bad_words
end

def set_top_words(option)
  top_words = 30 if option == :default
  top_words = option.to_i if option.class == String
  top_words
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
  options = args_parser.parse_options
  args_parser.show_help if options[:help]
  top_bad_words = set_top_bad_words(options[:top_bad_words])
  top_words = set_top_words(options[:top_words])
  name = options[:name]
  if name
    battles = BattlesAnalyzer.new.battles
    print_unknown_name(name) unless battles.key?(name.to_sym)
    print_unknown_action(name) if !top_bad_words && !top_words
  end
  if top_bad_words
    battles_analyzer = BattlesAnalyzer.new
    words_analyzer = WordsAnalyzer.new
    output = TopBadWordsOutput.new(battles_analyzer, words_analyzer, top_bad_words, name)
    output.calculate
    output.print_result
  end
  if top_words
    each_word_analyzer = EachWordAnalyzer.new
    output = TopWordsOutput.new(each_word_analyzer, top_words, name)
    output.calculate
    output.print_result
  end
rescue AnalyzerTextNameError => exeption
  exeption.show_message
rescue AnalyzerArgumentError => exeption
  exeption.show_message
end
