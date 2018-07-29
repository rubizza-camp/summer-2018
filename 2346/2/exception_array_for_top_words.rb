module Rap
  class ExceptionArrayForTopWords
    attr_reader :array

    def initialize
      @array = []
    end

    def fill_with_exceptions
      IO.foreach('./exceptions.txt') { |line| @array << line.delete("\n") }
    end

    def include?(exception_word)
      @array.include?(exception_word)
    end
  end
end
