# Helper to search post via onliner API
class PostParser
  attr_reader :link

  COMMENTS_LIMIT = 50

  def initialize(link)
    @link = link
  end

  def parse
    parse_json_from_api
  end

  private

  def post_id
    Mechanize.new.get(link).search('app[entity-id]').to_s.match(/\d+/).to_s
  end

  def prepare_request
    url = "https://comments.api.onliner.by/news/tech.post/#{post_id}/comments?limit=#{COMMENTS_LIMIT}"
    json = IO.open(url).read
    JSON.parse(json)
  end

  def parse_json_from_api
    comments = []
    request = prepare_request
    request['comments'].each { |comment_inf| comments << comment_inf['text'] }
    comments
  end
end
