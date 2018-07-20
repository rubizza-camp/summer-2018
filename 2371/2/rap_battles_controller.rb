require 'terminal-table'
require_relative 'content_manager'

# The RapBattlesController responsible for start searching info
class RapBattlesController
  attr_reader :options
  def initialize
    @options = {}
    @content_manager = ContentManager.new
  end

  def battles_files(battles_files)
    thread = show_progress
    @content_manager.handle_files(battles_files)
    thread.kill
  end

  def show_bad_words_rating(select)
    rows = @content_manager.authors_bad_words_info
    puts
    puts Terminal::Table.new rows: rows[0...select.to_i]
  end

  def show_favorite_words_rating
    raise FAVORITE_WORDS_INFO if @options.size != 2 || \
                                 !(@options.keys - %i[number name]).empty?
    @content_manager.author_favorite_words_info(@options[:number], @options[:name])
  end

  private

  def show_progress
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
  end
end

unless File.directory?('./texts/')
  puts NO_DIRECTORY
  exit
end
