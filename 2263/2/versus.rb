require_relative 'args_parser'
require_relative 'analyzer'

def scan_dictionary
  disabled_words_list = []
  dictionary = File.open('disabled_words_dictionary')
  dictionary.each do |word|
    disabled_words_list << word.match(/.*(?=\n)/).to_s
  end
  disabled_words_list
end

def delete_excess(list, number)
  counter = 0
  list.delete_if { (counter += 1) > number }
  list
end

def organize_top_bad_words(words, bad_words, battles, rounds, number)
  list = {}
  bad_words.each do |name, bad_words_number|
    list.merge!(name => { battles: battles[name],
                          bad_words: bad_words_number,
                          bad_words_per_battle: bad_words_number.fdiv(battles[name]),
                          words_per_round: words[name].fdiv(rounds[name]) })
  end
  list = list.sort_by { |element| element[1][:bad_words_per_battle] }
  list = list.reverse.to_h
  delete_excess(list, number)
end

def organize_top_words(list, number)
  disabled_words_list = scan_dictionary
  list.each do |name, words_hash|
    words_hash.delete_if { |word| disabled_words_list.include?(word.to_s) }
    words_hash = words_hash.sort_by { |element| element[1] }
    words_hash = words_hash.reverse.to_h
    list[name] = delete_excess(words_hash, number)
  end
  list
end

def print_top_bad_words(list)
  print '+---------------------------+------------+-------------------'
  print "---+------------------------------+--------------------------+\n"
  list.each do |name, info|
    printf("| %-25s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
           name.to_s + ':', info[:battles], info[:bad_words], info[:bad_words_per_battle], info[:words_per_round])
  end
  print '+---------------------------+------------+-------------------'
  print "---+------------------------------+--------------------------+\n"
end

def print_top_words(list)
  list.each do |name, words_hash|
    puts '+-------------------------------+'
    printf("| %-29s |\n", name.to_s + ':')
    puts '+-------------------------------+'
    words_hash.each { |word, num| printf("| %-15s - %3d times   |\n", word, num) }
  end
  puts '+-------------------------------+'
end

begin
  options = ArgsParser.new.options
  battles_analyzer = BattlesAnalyzer.new
  words_analyzer = WordsAnalyzer.new
  each_word_analyzer = EachWordAnalyzer.new
  if options[:help]
    ArgsParser.new.show_help
    exit
  end
  top_bad_words = 5 if options[:top_bad_words] == :default
  top_bad_words = options[:top_bad_words].to_i if options[:top_bad_words].class == String
  top_words = 30 if options[:top_words] == :default
  top_words = options[:top_words].to_i if options[:top_words].class == String
  name = options[:name]
  if name
    battles = battles_analyzer.battles
    unless battles.key?(name.to_sym)
      puts "I don't know MC #{name}, but I know these:"
      battles.each_key { |each_name| puts each_name }
      exit
    end
    if !top_bad_words && !top_words
      puts "I know MC #{name}, but I don't know what to do with it. Use --help to see all options"
      exit
    end
  end
  if top_bad_words
    words = words_analyzer.words(name)
    bad_words = words_analyzer.bad_words(name)
    battles = battles_analyzer.battles(name)
    rounds = battles_analyzer.rounds(name)
    list = organize_top_bad_words(words, bad_words, battles, rounds, top_bad_words)
    print_top_bad_words(list)
  end
  if top_words
    all_words = each_word_analyzer.each_word(name)
    list = organize_top_words(all_words, top_words)
    print_top_words(list)
  end
rescue AnalyzerTextNameError => exeption
  exeption.show_message
rescue AnalyzerArgumentError => exeption
  exeption.show_message
end
