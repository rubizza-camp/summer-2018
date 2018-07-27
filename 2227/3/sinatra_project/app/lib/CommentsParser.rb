# Parser comment
class CommentsParser
  COMMENTS_LIMIT = 50
  attr_reader :link
  def initialize(link)
    @link = link
  end

  def parse_comments_from_page
    comments = JSON.parse(parse_comment)['comments']
    comments.each_with_object([]) do |element, texts|
      texts << element['text'].tr("\n", ' ')
    end
  end

  def search_post_id
    page = Mechanize.new.get(link)
    page.search('app[entity-id]').to_s.match(/\d+/).to_s
  end

  def import_json_from_api
    "https://comments.api.onliner.by/news/tech.post/#{search_post_id}/comments?limit=#{COMMENTS_LIMIT}"
  end

  def parse_comment
    Mechanize.new.get(import_json_from_api).body.to_s
  end
end
