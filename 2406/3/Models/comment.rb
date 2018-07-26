module Models
  class Comment
    attr_reader :id, :description
    attr_accessor :rate

    def initialize(id, description, rate)
      @id = id
      @description = description
      @rate = rate
    end
  end
end
