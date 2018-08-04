class AzureTextAnalytics
  attr_reader :comments

  def initialize(comments)
    @comments = comments
  end

  def pull_out_score
    objs = generate_json_array
    objs.map { |obj| obj['documents'][0]['score'] }
  end

  private

  def make_uri
    uri = 'https://westcentralus.api.cognitive.microsoft.com'
    path = '/text/analytics/v2.0/sentiment'
    URI(uri + path)
  end

  def open_connection(uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https')
  end

  def recieve_one_comment_json(comment, uri)
    response = open_connection(uri) do |http|
      http.request RequestMaker.make_request(uri, comments.index(comment), comment)
    end
    JSON.pretty_generate(JSON(response.body))
  end

  def recieve_json
    uri = make_uri
    comments.map { |comment| recieve_one_comment_json(comment, uri) }
  end

  def generate_json_array
    recieve_json.map { |json| JSON.parse(json) }
  end
end
