require 'optparse'
require_relative 'constants'
require_relative 'rap_battles_controller'

ARGV << '-h' if ARGV.empty?

option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: rap_battles_controller.rb [options]'
  opts.on('--top-bad-words=number', 'Top bad words') do |number|
    raise BAD_WORDS_ERROR if number[/^\d+$/i].nil? \
 || number.empty? || ARGV.any?
    @controller.show_bad_words_rating(number) unless ARGV.any?
  end

  opts.on('--top-words=number', 'Number of top favorites words') do |number|
    raise FAVORITE_WORDS_INFO if number.empty? || ARGV.any?
    @controller.options[:number] = number
    @controller.show_favorite_words_rating unless ARGV.any?
  end

  opts.on('--name=name', 'Author name for top favorites words') do |name|
    raise FAVORITE_WORDS_INFO if name.empty?
    @controller.options[:name] = name
    @controller.show_favorite_words_rating unless ARGV.any?
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

begin
  raise NO_DIRECTORY_ERROR unless File.directory?('./texts/')
  @controller = RapBattlesController.new
  @controller.upload_files(Dir.entries('./texts/').reject { |item| item =~ /^\./i })
  option_parser.parse! ARGV
rescue OptionParser::InvalidOption => opt_error
  puts
  puts opt_error
rescue StandardError => error
  puts
  puts error.message
end
exit 1
