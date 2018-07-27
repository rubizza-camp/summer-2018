require 'sinatra'
require 'slim'
require 'ohm'

# Main controller
class IndexController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    slim :header_footer do
      slim :index
    end
  end

  get '/add' do
    slim :header_footer do
      slim :new
    end
  end

  post '/add' do
    Ohm.redis.call 'SET', 'article' + ((Ohm.redis.call 'GET', 'articles_count').to_i + 1).to_s, params[:link].to_s
    Ohm.redis.call 'SET', 'articles_count', ((Ohm.redis.call 'GET', 'articles_count').to_i + 1).to_s
    require_relative './models/article_rate.rb'
    rating = ArticleRate.new(params[:link].to_s)
    coment_count = rating.article.comments.size
    Ohm.redis.call 'SET', 'article' + (Ohm.redis.call 'GET', 'articles_count') + '_comments_count', coment_count.to_s
    rating.article_rate
    rating.article.comments.size.times do |index|
      text = rating.article.comments[index].text
      Ohm.redis.call 'SET', 'article' + (Ohm.redis.call 'GET', 'articles_count') + '_comment' + (index + 1).to_s, text
    end
    Ohm.redis.call 'SET', 'article' + (Ohm.redis.call 'GET', 'articles_count') + '_rate', rating.rate.to_i.to_s
    redirect '/'
  end

  # I use 'id' in show.slim, so it needed here
  # rubocop:disable Lint/UselessAssignment
  get '/show/:id' do
    slim :header_footer do
      slim :show do
        id = params['id']
      end
    end
  end
  # rubocop:enable Lint/UselessAssignment

  get '/annihilate' do
    slim :header_footer do
      slim :annihilate
    end
  end
end
