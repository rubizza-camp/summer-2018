# frozen_string_literal: true

require 'optionparser'
require_relative 'obscenity_tracker'

DIRECTORY = './rap-battles'.freeze
OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    ObscenityTracker.new(DIRECTORY, top_bad_words).run
  end.parse!
end
