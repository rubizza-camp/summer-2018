require './onliner_parser'
require './comments_reader'
require './api/text_analytics'
require './comments_rating'
# Class analyze comments and create json file
class CommentsJSON
  attr_reader :json
  def initialize(link)
    comments_array = CommentsReader.new(link).comments_list
    response_from_azure = TextAnalytic.new(comments_array).json
    @json = CommentsRating.new(response_from_azure, comments_array).rating
  end
end
puts CommentsJSON.new('https://tech.onliner.by/2018/07/24/dji-4').json
