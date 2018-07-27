require 'bundler'
Bundler.require

Dir.glob('./{controllers,helpers,models}/*.rb').each { |file| require file }

Article.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/0')

map('/') { run ArticleController }
