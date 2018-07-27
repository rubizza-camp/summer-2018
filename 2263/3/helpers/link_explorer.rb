# Class that performs parsing and analyzing comments, takes link to an articke and AZURE key
class LinkExplorer
  def initialize(link_obj, key_for_azure_analyzer)
    @link = link_obj
    @key = key_for_azure_analyzer
  end

  def explore
    comments_list = Parser.new(@link).comments
    comments_list.each_with_object([]) do |comment, comments_objs_list|
      sentiment = AZURESentimentAnalyzer.new(@key).analyze(comment)
      comments_objs_list << Comment.new(comment, sentiment)
    end
  end
end
