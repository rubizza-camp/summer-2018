require_relative 'parser/battles_files_parser'
require_relative 'author'
require_relative 'battle'
# The AuthorsInfoSearcher responsible for searching authors info
class AuthorsInfoSearcher
  def initialize(authors)
    @authors = authors
  end

  def authors_bad_words_rating
    @authors.sort_by { |author| -author.bad_words.size }
  end

  private

  def author_with_name(name)
    @authors.detect { |author| break author if SimilarItemsSearcher.compare_items(name, author.name) }
  end
end
