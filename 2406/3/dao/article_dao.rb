module DAO
  require 'json'
  require_relative '../models/article.rb'
  require_relative '../parsers/hash_parser/article_hash_parser'
  class ArticleDAO
    def initialize(redis)
      @redis = redis
    end

    def save(article)
      @redis.set size, HashParser::ArticleHashParser.create_hash(article).to_json
    end

    def select_by_id(id)
      HashParser::ArticleHashParser.parse_hash(JSON.parse(@redis.get id))
    end

    def select_all
      result = []
      (0...size).each { |id| result << select_by_id(id) } unless size.zero?
      result
    end

    private
    def size
      @redis.dbsize
    end
  end
end
