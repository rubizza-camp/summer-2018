class CommentsCreator
  def initialize(link)
    @link = link
  end

  def create
    comments_as_strings.map.with_index { |text, index| SpecificComment.new(text, ratings_of_comments[index]) }
  end

  private

  def ratings_of_comments
    @ratings_of_comments ||= TextChecker.new(comments_as_strings).check
  end

  def comments_as_strings
    @comments_as_strings ||= CommentsParser.new(@link).parse
  end
end
