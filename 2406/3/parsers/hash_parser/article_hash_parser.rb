module HashParser
  class ArticleHashParser
    require_relative '../../models/article'
    require_relative 'comment_hash_parser'

    def self.create_hash(article)
      tmp_list = []
      article.comment_list.each { |comment| tmp_list << HashParser::CommentHashParser.create_hash(comment) }
      { id: article.id,
        name: article.name,
        link: article.link,
        comment_list: tmp_list }
    end

    def self.parse_hash(hash)
      tmp_array = []
      hash['comment_list'].each { |value| tmp_array << HashParser::CommentHashParser.parse_hash(value) }
      Models::Article.new(hash['id'],
                          hash['name'],
                          hash['link'],
                          tmp_array)
    end
  end
end
