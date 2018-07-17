require_relative 'args_parser'
require_relative 'analyzer'
require_relative 'organizer'

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
    list = TopBadWordsOrganizer.new(battles_analyzer, words_analyzer, top_bad_words).organize
    TopBadWordsPrinter.new.print_result(list)
  end
  if top_words
    each_word_analyzer = EachWordAnalyzer.new(name)
    list = TopWordsOrganizer.new(each_word_analyzer, top_words).organize
    TopWordsPrinter.new.print_result(list)
  end
rescue AnalyzerTextNameError => exeption
  exeption.show_message
end
