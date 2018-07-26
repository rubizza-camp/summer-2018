require 'optparse'
require_relative 'constants'
require_relative 'authors_info_searcher'
require_relative 'parser/author_parser'
require_relative 'parser/battles_files_parser'
require_relative 'print/bad_words_table'
require_relative 'print/favorite_words_table'

ARGV << '-h' if ARGV.empty?

@options = {}

option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: authors_info_searcher.rb [options]'
  opts.on('--top-bad-words=number', 'Top bad words') do |number|
    raise BAD_WORDS_ERROR if number[/^\d+$/i].nil? || number.empty? || ARGV.any?
    authors = @searcher.authors_bad_words_rating
    BadWordsTable.new(authors).print(number)
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

begin
  raise NO_DIRECTORY_ERROR unless File.directory?('./texts/')
  files = BattlesFilesParser.new(Dir.entries('./texts/').reject { |item| item =~ /^\./i }).parse
  authors = AuthorParser.new(files).parse
  @searcher = AuthorsInfoSearcher.new(authors)
  option_parser.parse! ARGV
rescue OptionParser::InvalidOption => opt_error
  puts
  puts opt_error
rescue StandardError => error
  puts
  puts error.message
end
exit 1
