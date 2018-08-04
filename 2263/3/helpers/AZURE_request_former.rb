# Class, that forms request to AZURE
class AZURERequestFormer
  attr_reader :key

  def initialize(uri, key)
    @request = Net::HTTP::Post.new(uri)
    @key = key
  end

  def form(comments)
    @request['Content-Type'] = 'application/json'
    @request['Ocp-Apim-Subscription-Key'] = @key
    form_request_body(comments)
    @request
  end

  private

  def form_request_body(comments)
    counter = 0
    @request.body = comments.each_with_object('documents' => []) do |comment, body|
      body['documents'] << { 'id' => counter += 1, 'text' => comment }
    end.to_json
  end
end
