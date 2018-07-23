# frozen_string_literal: true

require 'optionparser'
require 'pry'
require_relative 'versus/battles_parser'
require_relative 'versus/battles_printer'
require_relative 'versus/data_extractor'

DIRECTORY = './rap-battles'.freeze

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_artists_limit|
    battles_parser = BattlesParser.new(top_artists_limit, DIRECTORY)
    battles_parser.fetch_battles
    all_battles = battles_parser.battles
    data_extractor = DataExtractor.new(all_battles, top_artists_limit)
    data_extractor.extract_data
    BattlesPrinter.print(data_extractor.extracted_data)
  end.parse!
end
