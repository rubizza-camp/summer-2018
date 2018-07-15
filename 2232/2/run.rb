require_relative 'level_manager'
require 'unicode_utils'
require 'optparse'

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    LevelManager.find_top_battlers(top_bad_words.to_i)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      LevelManager.find_top_words(name, top_words.to_i)
    end
  end
  parser.on('--name=') do |name|
    LevelManager.find_top_words(name, 30)
  end
end.parse!
