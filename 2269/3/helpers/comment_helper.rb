# Class
class CommentHelper
  def initialize
    @agent = Mechanize.new { |agnt| agnt.user_agent_alias = 'Mac Safari' }
    @agent.history_added = proc { sleep 1 }
  end

  attr_reader :agent, :data

  def retrieve_comments(path)
    article_id = @agent.get(path).css('.news_view_count').last.values[1]
    url = "https://comments.api.onliner.by/news/tech.post/#{article_id}/comments?limit=50&_=0.9841189675826583"
    response = agent.get(url)
    comments = []
    JSON.parse(response.body)['comments'].each { |elem| comments << elem['text'].tr("\n", ' ') }
    comments
  end

  def retrieve_rating(comments)
    @data = { documents: [] }
    comments.each_with_index do |comment, index|
      @data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment }
    end
    calculate_rating
  end

  def calculate_rating
    url = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    response = send_request(url)
    rating = []
    JSON.parse(response.body)['documents'].map do |value|
      rating << ((value['score'] * 200).round(0) - 100)
    end
    rating
  end

  def send_request(url)
    Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
      http.request(build_request(url))
    end
  end

  def build_request(url)
    key = File.read('api_key')
    request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => key)
    request.body = @data.to_json
    request
  end
end
