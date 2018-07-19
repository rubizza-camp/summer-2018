require 'optparse'
require File.expand_path(File.dirname(__FILE__) + '/rap_battles_manager')
require File.expand_path(File.dirname(__FILE__) + '/constants')

# The Application responsible for start searching info
class Application
  attr_reader :options
  def initialize
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
    @manager = RapBattlesManager.new
    @options = {}
  end

  def show_authors_bad_w_rating(number)
    prepare_to_search
    @manager.show_bad_words_info(number)
  end

  def show_favorite_w_rating
    if @options.size != 2 || !(@options.keys - %i[number name]).empty?
      @thread.kill
      return puts FAVORITE_WORDS_INFO
    end
    prepare_to_search
    @manager.show_favorite_info(@options[:number], @options[:name])
  end

  private

  def prepare_to_search
    @thread.kill
    begin
      @manager.upload_battles_files(Dir.entries('./texts/')
                                        .reject { |item| item =~ /^\./i })
    rescue StandardError => error
      puts error.message
    end
  end
end

unless File.directory?('./texts/')
  puts NO_DIRECTORY
  exit
end

ARGV << '-h' if ARGV.empty?

@app = Application.new

option_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: application.rb [options]'
  opts.on('--top-bad-words=number', 'Top bad words') do |number|
    return puts BAD_WORD_COMMAND_INFO if number != /\d+/ \
 || number.empty? || ARGV.any?
    @app.show_authors_bad_w_rating(number) unless ARGV.any?
  end

  opts.on('--top-words=number', 'Number of top favorites words') do |number|
    return puts FAVORITE_WORDS_INFO if number.empty? || ARGV.any?
    @app.options[:number] = number
    @app.show_favorite_w_rating unless ARGV.any?
  end

  opts.on('--name=name', 'Author name for top favorites words') do |name|
    return puts FAVORITE_WORDS_INFO if name.empty?
    @app.options[:name] = name
    @app.show_favorite_w_rating unless ARGV.any?
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

begin
  option_parser.parse! ARGV
rescue OptionParser::InvalidOption => error
  puts
  puts error
  exit 1
end
