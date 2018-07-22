require 'optparse'
require_relative 'InitializingParticipants'
require_relative 'ProcessingParticipant'
require_relative 'FormationParticipants'
require_relative 'Sum'
require_relative 'RapersArray'
require_relative 'TopBadWords'
require_relative 'PrintBestWord'
require_relative 'TopWordsLike'

OptionParser.new do |parser|
  parser.on('--top-bad-words=NAME') do |lib|
    var_bad_name = lib.to_i
    TopBadWords.print_bad(var_bad_name)
  end

  parser.on('--top-words=NAME') do |lib|
  end

  parser.on('--name=NAME') do |lib|
    name = lib
    TopWordsLike.top_best_words(name) unless name == ''
  end
end.parse!
