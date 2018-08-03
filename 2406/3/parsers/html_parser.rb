module Parser
  class HTMLParser
    require 'mechanize'

    API_PATH = 'https://comments.api.onliner.by/news/'.freeze
    MAX_COMMENTS = 50

    def self.to_article(link)
      @agent = Mechanize.new
      @data = @agent.get(link)
      id = @agent.get(link).search('.news_view_count').attr('news_id').value
      Models::Article.new(id, title(link), link, comment_list(link, id))
    end

    def self.title(link)
      @agent.get(link).search('.news-header__title').text.strip
    end

    def self.comment_list(link, id)
      result_comments = []
      hash_from_json(link, id)['comments'].each do |comment_hash|
        result_comments << Models::Comment.new(comment_hash['text'], 0)
      end
      result_comments
    end

    def self.hash_from_json(link, id)
      JSON.parse(@agent.get("#{API_PATH}#{link[%r{https://(\w+)}, 1]}.post/#{id}/comments?limit=#{MAX_COMMENTS}").body)
    end
  end
end
