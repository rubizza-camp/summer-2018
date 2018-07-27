require './api/request_api.rb'
require 'json'
# This class works with Microsoft Azure Text Analytic API
class TextAnalytic
  attr_reader :comments, :request_api, :request, :request_respond
  def initialize(comments_list)
    @comments        = comments_list
    @request_api     = RequestApi.new(request_data)
    @request         = request_api.request
    @request_respond = request_api.request_respond
  end
  def json
    JSON.parse request_respond.body
  end
  private
  def request_data
    data = {}
    comment_id = -1
    hash_array = []
    comments.each do |comment|
      comment_id += 1
      hash_array << { 'id' => comment_id, 'language' => 'ru', 'text' => comment }
    end
    data['documents'] = hash_array
    data
  end
end
