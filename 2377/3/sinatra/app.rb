require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/comment'
require_relative 'parser'
require_relative 'azure_api'
require 'ohm'
require 'yaml'
# Main class for application
class MyApp < Sinatra::Base
  post '/get-link' do
    link = Link.create link: params[:link]
    please = Parser.new
    please.get_comments(link)
    pray = TextAnalytics.new
    link.comments.each do |comment|
      pray.analyse(comment)
    end
    total = link.comments.inject(0) { |sum, comment| sum + comment.score.to_i } / link.comments.size
    link.update score: total
    erb :active_page
  end

  get '/' do
    erb :main
  end

  post '/clear' do
    Ohm.redis.call('FLUSHALL')
    erb :active_page
  end

  get '/analysis/:id' do
    @comments = Link[params[:id]].comments

    erb :analysis
  end

  # $0 is the executed file
  # __FILE__ is the current file
  run! if $PROGRAM_NAME == __FILE__
end
