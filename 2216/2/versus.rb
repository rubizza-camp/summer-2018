require 'optparse'
require 'russian_obscenity'
require 'unicode'
require 'active_support'
require 'active_support/core_ext'
require_relative 'bad_words_analyzer'
require_relative 'top_words_analyzer'
require_relative 'battle'
require_relative 'bad_words_table'
require_relative 'rapper'

# get env variables
# --------------------------------------------------------------------------------------------
options = { top_bad_words: nil, name: nil, top_words: nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: versus.rb [options]'
  opts.on('--top-bad-words number') do |number|
    options[:top_bad_words] = number
  end

  opts.on('--name name') do |name|
    options[:name] = name
  end

  opts.on('--top-words number') do |number|
    options[:top_words] = number
  end
end

parser.parse!
# ---------------------------------------------------------------------------------------------

if options.values.all?(&:nil?)
  puts 'Wrong number of parameters'
else
  participant_bad_words = {}
  participant_names = []
  input_vars = options.reject { |_key, value| value.nil? }

  file_with_names = File.open('participants', 'r')
  file_with_names.each_line { |line| participant_names << line.chop! }
  file_with_names.close

  # first level
  # --------------------------------------------------------------------------------------------

  if input_vars.include?(:top_bad_words)
    until options[:top_bad_words] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ &&
          Integer(options[:top_bad_words]) <= participant_names.size
      print 'Enter correct integer Number: '
      options[:top_bad_words] = gets.chomp
    end

    participant_names.each do |name|
      battle_texts = {}
      battle_words = []
      participant = Rapper.new(name)
      participant.battles.each do |battle_title|
        battle = Battle.new(battle_title)
        battle_texts[battle_title] = battle.text
        battle_words += battle.words
      end
      analyzer = BadWordsAnalyzer.new(battle_texts, battle_words)
      participant_bad_words[name] = analyzer.analyze_bad
    end

    columns = participant_bad_words.min.flatten.size
    table = BadWordsTable.new(participant_bad_words, Integer(options[:top_bad_words]), columns)
    table.print(:console)
  end
  # -------------------------------------------------------------------------------------------

  # second level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:name)
    options[:top_words] = 30 if options[:top_words].nil? || options[:top_bad_words] == ''
    options[:name] = options[:name].tr('_', ' ')

    if participant_names.include?(options[:name])
      battle_texts = {}
      battle_words = []
      participant = Rapper.new(options[:name])
      participant.battles.each do |battle_title|
        battle = Battle.new(battle_title)
        battle_texts[battle_title] = battle.text
        battle_words += battle.words
      end
      analyzer = TopWordsAnalyzer.new(battle_texts, battle_words)
      top_words = analyzer.analyze_top
      Integer(options[:top_words]).times do
        word_with_count = top_words.shift
        puts "#{word_with_count[0]} - #{word_with_count[1]} раз"
      end
    else
      puts 'Неизвестное имя ' + options[:name] + '. Вы можете ввести одно из следующих имён: '
      participant_names.each { |name| puts name }
    end
  end
  # -------------------------------------------------------------------------------------------
end
