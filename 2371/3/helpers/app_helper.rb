require 'net/https'
require 'uri'
require 'json'

require_relative 'article_helper'
require_relative 'comment_helper'
require_relative '../controllers/factories/data_handler_factory'
require_relative '../controllers/factories/request_factory'

class AppHelper
  def initialize(article_url)
    @article_url = article_url
  end

  def article
    @article = ArticleHelper.new(id: 1, link: @article_url, comments: [])
    comments.each { |comment| @article.comments << CommentHelper.new(comment) }
    @article.add_comments_score(scores)
    @article
  end

  private

  def onliner_api_url
    data_handler = DataHandlerFactory.data_handler('onliner_site')
    api_params = RequestFactory.request_handler('onliner', url: @article_url)
                     .make_request(data_handler)
    "https://comments.api.onliner.by/news/#{api_params['entity-type']}/#{api_params['entity-id']}/comments?limit=50"
  end

  def comments
    data_handler = DataHandlerFactory.data_handler('onliner_api')
    RequestFactory.request_handler('onliner', url: onliner_api_url)
        .make_request(data_handler)
  end

  def scores
    data_handler = DataHandlerFactory.data_handler('azure_api')
    uri = 'https://westcentralus.api.cognitive.microsoft.com'
    path = '/text/analytics/v2.0/sentiment'
    args = {
        uri: uri,
        path: path,
        document:@article.azure_document,
        api_key: 'a8264e9ea5634091b6a5c62f42c83eef'
    }
    RequestFactory.request_handler('azure_api', args).make_request(data_handler)
  end
end

# puts ApplicationHelper.new("https://tech.onliner.by/2018/07/24/magic").search_article_comments