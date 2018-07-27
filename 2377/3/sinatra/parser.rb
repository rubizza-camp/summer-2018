require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
# Parsing of comments
class Parser
  def get_comments(link)
    response = Net::HTTP.get_response(URI.parse(link.link)).body
    news_id = Nokogiri::HTML(response).xpath('//span[@news_id]').to_s.match(/\d+/).to_s
    @json_comments = JSON.parse(Net::HTTP.get_response(URI.parse('https://comments.api.onliner.by/news/tech.post/' + news_id + '/comments?limit=50')).body)
  end

  def parse_json(link)
    comments = @json_comments['comments'].each.map { |hash| hash['text'] }
    comments.each do |comment|
      link.comments.push(Comment.create(comment: comment))
    end
  end
end
