require 'optparse'
require 'terminal-table'
require 'russian_obscenity'
require 'pry'
require 'russian'

Dir[File.join('lib', '*.rb')].each { |file| require_relative file }

options = { 'top-bad-words' => nil }
parser = OptionParser.new do |opts|
  opts.banner = 'Info for all options'
  opts.on('--top-bad-words=number', 'top-bad-words') do |number|
    options['top-bad-words'] = number
  end
end

parser.parse!
puts TableOfStatistic.make_table(options['top-bad-words']) unless options['top-bad-words'].nil?
