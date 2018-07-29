require 'json'
require 'mechanize'
require 'sinatra'
require 'net/https'

URI_AZURE = 'https://westcentralus.api.cognitive.microsoft.com'.freeze
PATH_AZURE = '/text/analytics/v2.0/sentiment'.freeze

class RatingCounter
	attr_reader :data, :uri, :request
	def initialize(comments, api_key)
		@uri = URI_AZURE(URI_AZURE + PATH_AZURE)
		@data = { documents: [] }
		data_get_ready_to_analyze(comments)
		@request = request_get_ready_to_analyze(api_key)
	end

	def run
		output_data(send_request)
	end

	private

	def data_get_ready_to_analyze(comments)
		comments.each_with_index do |comment, index|
      @data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment }
    end
	end

	def send_request
		Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
	end

	def output_data(response)
		JSON.parse(response.body)['documents'].map do |data|
			((data['score'] * 200).to_i - 100)
		end
	end

	def prepare_request(api_key)
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => api_key)
    request.body = data.to_json
    return request
  end
end