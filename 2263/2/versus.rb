require_relative 'args_parser'
require_relative 'analyzer'
require_relative 'organizer'

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
  options = ArgsParser.new.options_default_values
  Help.new.show_help if options[:help]
  top_bad_words = options.key?(:top_bad_words) ? options[:top_bad_words].to_i : nil
  top_words = options.key?(:top_words) ? options[:top_words].to_i : nil
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
rescue AnalyzerTextNameError => exception
  puts exception.message
rescue OptionParser::InvalidOption => exception
  puts exception.message.capitalize
end
