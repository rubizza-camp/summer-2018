require 'open-uri'
require 'json'

class JSONParser
  attr_reader :comments_url
  attr_reader :comments

  def initialize(comments_url)
    @comments_url = comments_url
  end

  def comments
    comments = send_comments_request
  end

  private

  def send_comments_request
    json = URI.parse(@comments_url).read
    JSON.parse(json)['comments'].map do |comment|
      comment['text']
    end
  end
end

# content = JSONParser.new('https://comments.api.onliner.by/news/people.post/570149/comments?limit=5').comments
# p content
