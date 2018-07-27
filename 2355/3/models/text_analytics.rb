require 'net/https'
require 'uri'
require 'json'

# This class responsible for analyzing comments
class TextAnalytics
  attr_reader :documents, :access_key, :uri

  def initialize(documents)
    @documents = documents
    @access_key = '7614507e97184bfd9f38e1d93fa130e8' # use it, if you want... I don't mind
    path = '/text/analytics/v2.0/sentiment'
    @uri = URI('https://westcentralus.api.cognitive.microsoft.com' + path)
  end

  # This method is written in accordance with the documentation of Azura,
  # so it's not my fault that reek swears on TooManyStatements and Rubocop swears on EVERYTHING!
  # This method smells of :reek:TooManyStatements
  # rubocop:disable Style/HashSyntax
  # rubocop:disable Style/NestedParenthesizedCalls
  # rubocop:disable Style/ColonMethodCall
  # rubocop:disable Style/RedundantParentheses
  # rubocop:disable Lint/ParenthesesAsGroupedExpression
  def analyze
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = @access_key
    request.body = @documents.to_json

    response = Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON.parse(JSON::pretty_generate (JSON (response.body)))
  end
  # rubocop:enable Style/HashSyntax
  # rubocop:enable Style/NestedParenthesizedCalls
  # rubocop:enable Style/ColonMethodCall
  # rubocop:enable Style/RedundantParentheses
  # rubocop:enable Lint/ParenthesesAsGroupedExpression
end
