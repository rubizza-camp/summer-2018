# this class creates and sends request to Azure
class RequestGenerator
  attr_reader :request, :uri
  def initialize(data)
    @uri = URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    @request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = 'c3d16669aba747e5be12a669a1b7736a'
    request.body = data.to_json
  end

  def response
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end
end
