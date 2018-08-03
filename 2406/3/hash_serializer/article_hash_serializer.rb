module HashSerializer
  class ArticleHashSerializer
    def self.create_hash(article)
      tmp_list = []
      article.comment_list.each { |comment| tmp_list << HashSerializer::CommentHashSerializer.create_hash(comment) }
      { id: article.id,
        name: article.name,
        link: article.link,
        comment_list: tmp_list }
    end

    def self.parse_hash(hash)
      tmp_array = []
      hash['comment_list'].each { |value| tmp_array << HashSerializer::CommentHashSerializer.parse_hash(value) }
      Models::Article.new(hash['id'],
                          hash['name'],
                          hash['link'],
                          tmp_array)
    end
  end
end
