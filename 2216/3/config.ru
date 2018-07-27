require_relative './controllers/application_controller'
Article.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')
run ApplicationController
