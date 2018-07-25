require_relative '../constants'
require_relative '../similar_items_searcher'
require_relative 'parser'
# The BattlesFilesParser responsible for parse battles text files
class BattlesFilesParser < Parser
  private

  def parse_content(content)
    return unless File.file?("./texts/#{content}")
    name = content[/^.+?(?='?(а|a|ы)?\s+(против|vs))/i].strip.downcase
    texts = [File.read("./texts/#{content}")]
    parsed_data << { name: name, battles_texts: texts } unless parsed_data.detect do |data|
      data[:battles_texts] += texts if SimilarItemsSearcher.compare_items(name, data[:name])
    end
  end
end
