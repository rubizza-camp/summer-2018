require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'
# Parsing of comments
class Parser
 
  def get_comments(link)
    json_comments = JSON.parse(Net::HTTP.get_response(URI.parse('https://comments.api.onliner.by/news/tech.post/' + get_id(link) + '/comments?limit=50')).body)
    comments = json_comments['comments'].each.map { |hash| hash['text'] }
    comments.each do |comment|
        link.comments.push(Comment.create(comment: comment))
    end
  end

  private

  def response(link)
    Net::HTTP.get_response(URI.parse(link.link)).body
  end

  def get_id(link)
    Nokogiri::HTML(response(link)).xpath('//span[@news_id]').to_s.match(/\d+/).to_s
  end


end
