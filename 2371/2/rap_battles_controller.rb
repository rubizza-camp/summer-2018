require 'terminal-table'
require_relative 'content_manager'
require_relative 'files_reader'
# The RapBattlesController responsible for start searching info
class RapBattlesController
  attr_reader :options
  def initialize
    @options = {}
    @content_manager = ContentManager.new
  end

  def upload_files(battles_files)
    thread = show_progress
    @content_manager.handle_files_info(FilesReader.new(battles_files).files_content)
    thread.kill
  end

  def show_bad_words_rating(select)
    authors = @content_manager.authors
    raise 'No authors found' unless authors.any?
    table_print(authors.sort_by! { |author| -author.bad_words.size }.map(&:to_print)[0...select.to_i])
  end

  def show_favorite_words_rating
    raise FAVORITE_WORDS_INFO if @options.size != 2 || \
                                 !(@options.keys - %i[number name]).empty?
    @content_manager.authors.author_favorite_words_info(@options[:number], @options[:name])
  end

  private

  def table_print(rows)
    puts
    puts Terminal::Table.new rows: rows
  end

  def author_favorite_words_info(select, name)
    puts [select, name].to_s
  end

  def show_progress
    @thread = Thread.new do
      0.step(1000, 5) do |step|
        printf("\rSearching:  %-20s", '*' * (step / 5))
        sleep(0.5)
      end
    end
  end
end
