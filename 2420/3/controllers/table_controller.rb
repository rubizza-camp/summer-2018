require 'ohm'
require 'redis'
# class TableController
class TableController < ApplicationController
  get '/' do
    erb :table
  end

  post '/' do
    scores = []
    article = Article.create(url: params[:new_url]) unless params[:new_url].empty?
    comments = Pars.new(params[:new_url]).comments
    comments.each do |comment|
      score = ManipulationCommentScore.new(Analytics.new(comment).run).run
      scores << score
      comment_attribute = Comment.create(body: comment, comment_rating: score)
      article.comments.push(comment_attribute)
    end
    article.update article_rating: ManipulationArticleScore.new(scores).run
    erb :table
  end
end
