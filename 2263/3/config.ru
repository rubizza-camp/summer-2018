Bundler.require(:development)

require 'sinatra/base'

Dir.glob('./{helpers,controllers,views,models}/*.rb').each { |file| require file }

ArticleModel.redis = Redic.new('redis://127.0.0.1:6379/0')
CommentModel.redis = Redic.new('redis://127.0.0.1:6379/0')

map('/') { run CommentsController }
