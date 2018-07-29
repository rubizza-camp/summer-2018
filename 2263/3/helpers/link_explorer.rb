# Class that performs parsing and analyzing comments, takes link to an articke and AZURE key
class LinkExplorer
  attr_reader :link, :key

  def initialize(link_obj, key_for_azure)
    @link = link_obj
    @key = key_for_azure
  end

  def explore
    comments_list = Parser.new(@link).comments
    sentiment_list = AZURESentimentAnalyzer.new(@key).analyze(comments_list)
    make_comments_objects(comments_list, sentiment_list)
  end

  private

  def make_comments_objects(comments, sentiments)
    comments_objects_list = []
    comments.each_index { |index| comments_objects_list << Comment.new(comments[index], sentiments[index]) }
    comments_objects_list
  end
end
