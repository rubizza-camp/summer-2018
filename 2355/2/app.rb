require './first_level.rb'
require './second_level.rb'
require 'optparse'

OptionParser.new do |opts|
  opts.on('--top-bad-words=') { |bad| FirstLevel.new(bad).print_table }
  opts.on('--top-words=') do |most|
    opts.on('--name=') do |battler_name|
      SecondLevel.new(most, battler_name).name_check
    end
  end
end.parse!
