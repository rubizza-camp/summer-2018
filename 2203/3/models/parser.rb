require 'mechanize'
require 'json'

# This class search post id from link to after send this id and get json with comments
class Parser
  attr_reader :link, :json

  COMMENTS_LIMIT = 50

  def initialize(link)
    @link = link
    @json = parse_json
  end

  private

  def search_post_id
    Mechanize.new.get(link).search('app[entity-id]').to_s.match(/\d+/).to_s
  end

  def import_json_from_api
    "https://comments.api.onliner.by/news/tech.post/#{search_post_id}/comments?limit=#{COMMENTS_LIMIT}"
  end

  def parse_json
    JSON.parse Mechanize.new.get(import_json_from_api).body
  end
end
