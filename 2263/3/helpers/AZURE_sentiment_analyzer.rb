# Class, that performs requests to AZURE sentiment analyzing API
class AZURESentimentAnalyzer
  attr_reader :access_key, :uri

  def initialize(access_key)
    @access_key = access_key
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def analyze(comments)
    request = AZURERequestFormer.new(@uri, @access_key).form(comments)
    response = send_request(request)
    sentiment_list(response)
  end

  private

  def send_request(request)
    response = Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON.pretty_generate(JSON(response.body))
  end

  def sentiment_list(response)
    response_hash = JSON.parse(response)
    response_hash['documents'].each_with_object([]) { |info, sentiment_list| sentiment_list << info['score'] }
  end
end
