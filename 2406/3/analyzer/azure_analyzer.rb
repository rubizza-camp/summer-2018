module Analyzer
  class AzureAnalyzer
    require 'uri'
    require 'net/https'

    SECRET_FILE_NAME = 'keystore.yml'.freeze
    API_URL = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
    ACCESS_KEY = File.read(SECRET_FILE_NAME).freeze
    CONTENT_TYPE = 'application/json'.freeze

    def initialize
      @uri = URI(API_URL)
      @data = {}
    end

    def execute(article)
      mark(article.comment_list)
      article
    end

    private

    def mark(comment_list)
      format_comments(comment_list)
      rate_map = take_response(send_request)
      comment_list.each_with_index { |value, index| value.rate = rate_map[index] }
    end

    def send_request
      request = Net::HTTP::Post.new(@uri, 'Content-Type' => CONTENT_TYPE, 'Ocp-Apim-Subscription-Key' => ACCESS_KEY)
      request.body = @data.to_json
      Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
        http.request(request)
      end
    end

    def take_response(request)
      JSON.parse(request.body)['documents'].map do |data|
        (data['score'] * 200).to_i - 100
      end
    end

    def format_comments(comment_list)
      @data[:documents] = []
      comment_list.each_with_index do |comment, index|
        @data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment.description }
      end
    end
  end
end
