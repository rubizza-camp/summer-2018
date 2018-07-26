require_relative 'parser'
require_relative '../author'
require_relative '../battle'
# The AuthorParser responsible for parsing authors from parsed files content
class AuthorParser < Parser
  private

  def parse_content(content)
    parsed_data << Author.new(content[:name])
    parsed_data.last.add_battles(content[:battles_texts].map { |battle_text| Battle.new(battle_text) })
  end
end
