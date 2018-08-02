require 'open-uri'
require 'json'

class JSONParser
  attr_reader :comments_url
  attr_reader :comments

  def initialize(comments_url)
    @comments_url = comments_url
    @comments_json = []
  end

  def comments
    #@comments_json = filter_response(send_comments_request)
    @comments = send_comments_request
  end

  private

  def send_comments_request
    json = open(@comments_url).read
    JSON.parse(json)['comments'].map do |comment|
      comment['text']
    end
  end

  def filter_response(response)
    response.map do |elem|
      elem unless (elem.select {|hash,value| hash['marks'] && value['likes'] > 0}) == {}
      # elem unless (res == {})
    end
  end
end

#content = JSONParser.new('https://comments.api.onliner.by/news/people.post/570149/comments?limit=5').comments
#p content
