module Repository
  require 'json'

  class Article
    def initialize(redis)
      @redis = redis
    end

    def save(article)
      @redis.set size, HashSerializer::ArticleHashSerializer.create_hash(Analyzer::AzureAnalyzer.new.execute(article)).to_json
    end

    def select_by_id(id)
      HashSerializer::ArticleHashSerializer.parse_hash(JSON.parse(@redis.get(id)))
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
