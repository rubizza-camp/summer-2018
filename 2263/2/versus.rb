require_relative 'args_parser'
require_relative 'directory_explorer'
require_relative 'file_explorer'
require_relative 'word'
require_relative 'round'
require_relative 'battle'
require_relative 'rapper'
require_relative 'handler'
require_relative 'printer'

def print_unknown_name_and_exit(name, names_list)
    puts "I don't know MC #{name}, but I know these:"
    names_list.each { |name| puts name }
    exit
  end
  
  def print_unknown_action_and_exit(name)
    puts "I know MC #{name}, but I don't know what to do with it. Use --help to see all options"
    exit
  end
  
  begin
    options = ArgsParser.new.options_default_values
  
    Help.new.show_help_and_exit if options[:help]
    top_bad_words_opt = options[:top_bad_words]&.to_i
    top_words_opt = options[:top_words]&.to_i
    name_opt = options[:name]
  
    explorer = DirectoryExplorer.new(name_opt)
    names_list = explorer.make_names_list
    if name_opt
      print_unknown_name_and_exit(name_opt, names_list) unless names_list.include?(name_opt)
      print_unknown_action_and_exit(name_opt) if !top_bad_words_opt && !top_words_opt
    end
  
    rappers_hash = explorer.make_rappers_hash
    Handler.new(rappers_hash, Printer.new).top_rude_rappers(top_bad_words_opt) if top_bad_words_opt
    if top_words_opt
      dictionary = File.open('disabled_words_dictionary')
      Handler.new(rappers_hash, Printer.new).top_words(top_words_opt, dictionary)
    end
  rescue OptionParser::InvalidOption => exception
    puts exception.message.capitalize
  end
