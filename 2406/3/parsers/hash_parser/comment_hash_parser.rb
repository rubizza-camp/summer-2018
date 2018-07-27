module HashParser
  class CommentHashParser
    require_relative '../../models/comment'
    def self.create_hash(comment)
      {:description => comment.description, :rate => comment.rate}
    end

    def self.parse_hash(hash)
      Models::Comment.new(hash['description'], hash['rate'])
    end
  end
end