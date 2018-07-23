require_relative 'author'
require_relative 'constants'
require 'set'
# The AuthorsContentManager responsible for manage authors
class AuthorsContentManager
  def initialize
    @authors_set = Set.new
  end

  def add?(content)
    raise NO_CONTENT_WARN unless content.any?
    content.each do |info|
      find_or_create_author_by_name(info[:name]).add_battle(Battle.new(info[:battle_text]))
    end
  end

  def authors
    raise NO_AUTHOR_WARN unless @authors_set.to_a.any?
    @authors_set
  end

  def author_with_name(name)
    raise NO_AUTHOR_WARN unless @authors_set.to_a.any?
    find_author_by(name)
  end

  private

  def find_or_create_author_by_name(name)
    author = find_author_by(name) || Author.new(name)
    @authors_set.add? author
    author
  end

  def find_author_by(name)
    unless @authors_set.detect do |author|
      next unless author.name?(name)
      return author
    end
    end
  end
end
