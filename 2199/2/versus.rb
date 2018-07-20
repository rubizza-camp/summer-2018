require 'yaml'
require 'bundler'
require_relative 'participant_store'
Bundler.require

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    top_participants = ParticipantStore.new('rap-battles').top_by_bad_words(top_bad_words.to_i)
    puts Terminal::Table.new(rows: top_participants.map(&:table_row))
  end
  parser.on('--help') do
    puts 'Usage:'
    puts 'Parameter --top-bad-words=N show N the most abusive rapers.'
  end
end.parse!
