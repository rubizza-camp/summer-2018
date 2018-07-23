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
require_relative 'bad_words_task'
require_relative 'top_words_task'

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
  participants = []
  File.open('participants', 'r').each_line { |line| participants << line.chop! }
  input_vars = options.reject { |_key, value| value.nil? }

  # first level
  # --------------------------------------------------------------------------------------------

  if input_vars.include?(:top_bad_words)
    until num_of_top =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ &&
          Integer(num_of_top) <= participants.size
      print 'Enter correct integer Number: '
      input_vars[:top_bad_words] = gets.chomp
    end
    BadWordsTask.new(input_vars[:top_bad_words]).run_bad_words_analysis
  end
  # -------------------------------------------------------------------------------------------

  # second level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:name)
    options[:top_words] = 30 if options[:top_words].nil? || options[:top_bad_words] == ''
    options[:name] = options[:name].tr('_', ' ')

    if participants.include?(options[:name])
      TopWordsTask.new(input_vars[:top_words], options[:name]).run_top_words_analysis
    else
      puts 'Неизвестное имя ' + options[:name] + '. Вы можете ввести одно из следующих имён: '
      participants.each { |name| puts name }
    end
  end
  # -------------------------------------------------------------------------------------------
end
