require_relative 'scraper.rb'
require_relative 'form_comments.rb'
require 'net/https'
require 'uri'
require 'json'

# Take messages from sorted by onliner's rating array
class PackCreator
  def initialize
    @array_of_objects = Analyze.new.sort_array_of_objects
    @pack = []
  end

  def create_hash_of_comments
    @array_of_objects.each { |obj| @pack << obj.message }
  end
end

# Forms azure body for request
class AzureHash 
  def initialize
    @pack = PackCreator.new.create_hash_of_comments
  end

  def form_hash
    data = {'documents' => []}
    @pack.each_with_index do |comment, index|
       data['documents'] << {'id' => (index + 1).to_s, 'text' => comment.message} 
    end
    data
  end
end

ACCESS_KEY = '84696ed14a214431b4e25945879458e2'.freeze
PATH = '/text/analytics/v2.0/sentiment'.freeze
API_URI = 'https://westcentralus.api.cognitive.microsoft.com'.freeze

uri = URI(API_URI + PATH)

documents = AzureHash.new.form_hash

puts 'Please wait a moment for the results to appear.'

request = Net::HTTP::Post.new(uri)
request['Content-Type'] = 'application/json'
request['Ocp-Apim-Subscription-Key'] = ACCESS_KEY
request.body = documents.to_json

response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
  http.request(request)
end

# p JSON.parse(response.body)

JSON.parse(response.body).each do |variable|
  p variable
end
