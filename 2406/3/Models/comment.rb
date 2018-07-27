module Models
  class Comment
    attr_reader :description, :rate

    def initialize(description, rate)
      @description = description
      @rate = rate
    end
  end
end
