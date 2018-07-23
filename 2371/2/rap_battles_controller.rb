require_relative 'authors_content_manager'
require_relative 'files_parser'
require_relative 'print/bad_words_table'
require_relative 'print/favorite_words_table'
require_relative 'progress'
# The RapBattlesController responsible for start searching info
class RapBattlesController
  attr_reader :options
  def initialize
    @options = {}
    @content_manager = AuthorsContentManager.new
    @progress = Progress.new
  end

  def upload_files(battles_files)
    puts NO_CONTENT_WARN unless battles_files.any?
    @progress.show
    @content_manager.add_authors_from_content(FilesParser.new(battles_files).parse_files)
    @progress.hide
  end

  def show_bad_words_rating(select)
    BadWordsTable.new(@content_manager.authors).print(select)
  end

  def show_favorite_words_rating
    raise FAV_WORDS_ERROR if @options.size != 2 || \
                             !(@options.keys - %i[number name]).empty?

    FavoriteWordsTable.new(@content_manager.authors).print
  end
end
