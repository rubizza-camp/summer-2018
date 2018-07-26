require_relative 'lib/statistics'
require 'bundler'
Bundler.require
require 'optparse'

statistics = Statistics.new

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    statistics.find_top_battlers(top_bad_words.to_i)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      statistics.find_top_words(name, top_words.to_i)
    end
  end
  parser.on('--name=') do |name|
    statistics.find_top_words(name, 30) # default word count
  end
end.parse!
