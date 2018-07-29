require_relative 'line'

module Rap
  class Round
    attr_reader :lines

    def initialize
      @lines = []
    end

    def push_line(line)
      @lines << line
    end

    def all_words
      lines.inject([]) { |all_words, line| all_words << line.all_words }
    end

    def bad_words
      lines.inject([]) { |bad_words, line| bad_words << line.bad_words }
    end
  end
end
