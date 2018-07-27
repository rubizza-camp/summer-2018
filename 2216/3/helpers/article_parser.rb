class ArticleParser
  attr_reader :link
  MAX_NUM_OF_COMMENTS = 50

  def initialize(link)
    @link = link
  end

  def parse
    parse_json
  end

  private

  def make_post_id
    agent = Mechanize.new
    page = agent.get(link)
    page.search('app[entity-id]').to_s.match(/\d+/).to_s
  end

  def make_objs
    url = "https://comments.api.onliner.by/news/tech.post/#{make_post_id}/comments?limit=#{MAX_NUM_OF_COMMENTS}"
    json = IO.open(url).read
    JSON.parse(json)
  end

  def parse_json
    comments = []
    objs = make_objs
    objs['comments'].each do |comment_inf|
      comments << comment_inf['text']
    end
    comments
  end
end
