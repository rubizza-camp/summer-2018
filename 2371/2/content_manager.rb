require_relative 'author'
# The ContentManager responsible for searching authors info in files
class ContentManager
  attr_reader :authors
  def initialize
    @authors = []
  end

  def handle_files_info(files_info)
    raise 'No authors found' unless files_info.any?
    files_info.each do |info|
      find_same_author(Author.new(info[:name])).add_battle(Battle.new(info[:battle_text]))
    end
  end

  private

  def find_same_author(new_author)
    unless @authors.detect do |author|
      next unless author.name?(new_author.name)
      return author
    end
      @authors << new_author
      new_author
    end
  end
end
