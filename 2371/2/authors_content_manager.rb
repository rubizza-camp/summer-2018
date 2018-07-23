require_relative 'author'
require_relative 'constants'
require 'set'
# The AuthorsContentManager responsible for manage authors
class AuthorsContentManager
  attr_reader :authors
  def initialize
    @authors = Set.new
  end

  def add_authors_from_content(content)
    content.each do |data|
      name = data[:name]
      author = author_with_name(name) || Author.new(name)
      @authors.add? author
      author.add_battle(Battle.new(data[:battle_text]))
    end
  end

  def author_with_name(name)
    @authors.detect { |author| break author if author.name?(name) }
  end
end
