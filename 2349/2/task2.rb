require 'optparse'
require_relative 'initializing_participants'
require_relative 'processing_participant'
require_relative 'formation_participants'
require_relative 'sum'
require_relative 'rapers_array'
require_relative 'top_bad_words'
require_relative 'print_best_word'

OptionParser.new do |parser|
  all_batlers = InitializingParticipants.new.name_batlers
  choice_batlers = InitializingParticipants.new.choice_participant
  comparison = FormationParticipants.new(choice_batlers).name_comparison
  rap = RapersArray.new(comparison, choice_batlers.length, all_batlers).battle_men_array

  parser.on('--top-bad-words=NAME') do |lib|
    var_bad_name = lib.to_i
    TopBadWords.new(var_bad_name, rap).print_bad
  end

  parser.on('--top-words=NAME') do |lib|
  end

  parser.on('--name=NAME') do |lib|
    name = lib
    PrintBestWord.new(rap, all_batlers, name).top_best_words
  end
end.parse!
