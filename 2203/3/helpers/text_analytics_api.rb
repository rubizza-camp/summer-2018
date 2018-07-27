class TextAnalyticsApi
  attr_reader :comments

  def initialize(comments)
    @comments = comments
  end

  def score
    array_from_json.map { |result| result['documents'][0]['score'] }
  end

  private

  def uri_link
    URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def open_connection(uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https')
  end

  def json_with_comments(comment, uri)
    response = open_connection(uri) do |http|
      http.request RequestMaker.make_request(uri, comments.index(comment), comment)
    end
    JSON.pretty_generate(JSON(response.body))
  end

  def json
    uri = uri_link
    comments.map { |comment| json_with_comments(comment, uri) }
  end

  def array_from_json
    json.map { |json| JSON.parse(json) }
  end
end