require 'dotenv/load'
# analyze comment
class CommentsAnalyzer
  ACCESS_KEY = ENV['ACCESS_KEY']
  AZURE_ENDPOINT = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze

  def initialize(texts)
    @texts = texts
  end

  # :reek:NestedIterators
  # rubocop:disable Metrics/AbcSize
  def analyze
    JSON.parse(run_request.body)['documents'].each_with_object([]) do |result, store|
      document = documents.find { |doc| doc[:id].to_s == result['id'] }
      store << {
        text: document[:text],
        rating: result['score'] * 200 - 100
      }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def azure_endpoint
    @azure_endpoint ||= URI(AZURE_ENDPOINT)
  end

  # :reek:FeatureEnvy
  def request
    Net::HTTP::Post.new(azure_endpoint).tap do |request|
      request['Content-Type'] = 'application/json'
      request['Ocp-Apim-Subscription-Key'] = ACCESS_KEY
      request.body = serialized_texts_json
    end
  end

  def documents
    @documents ||= @texts.map do |text|
      { id: text.object_id, language: 'ru', text: text }
    end
  end

  def serialized_texts_json
    { documents: documents }.to_json
  end

  def run_request
    https = Net::HTTP.new(azure_endpoint.host, azure_endpoint.port)
    https.use_ssl = true
    https.request(request)
  end
end
