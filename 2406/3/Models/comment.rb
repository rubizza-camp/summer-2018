module Models
  class Comment
    attr_reader :name, :description, :rate

    def initialize(name, description, rate)
      @name = name
      @description = description
      @rate = rate
    end
  end
end
