require_relative 'level_manager'
require 'bundler'
Bundler.require
require 'optparse'

level_manager = LevelManager.new

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    level_manager.find_top_battlers(top_bad_words.to_i)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      level_manager.find_top_words(name, top_words.to_i)
    end
  end
  parser.on('--name=') do |name|
    level_manager.find_top_words(name, 30) # default word count
  end
end.parse!
