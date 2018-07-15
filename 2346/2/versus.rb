require 'optparse'
require_relative 'class_analysis'

analyzer = Analysis.new

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |max|
    puts 'Самые нецензурные участники'
    analyzer.first_level(max.to_i)
  end
  parser.on('--name=') do |name|
    parser.on('--top-words=') do |qty|
      analyzer.second_level(name, qty.to_i)
    end
  end
end.parse!
