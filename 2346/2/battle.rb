require_relative 'round'

module Rap
  UNWANTEDBEGIN = %r{(\./rap-battles/) ?}
  UNWANTEDEND = /( против | vs | VS ).*/
  class Battle
    attr_reader :path, :rounds

    def initialize(path)
      @path = path
      @rounds = []
    end

    def participant_name
      path.gsub(UNWANTEDBEGIN, '').gsub(UNWANTEDEND, '')
    end

    def fill_rounds
      IO.foreach(path) do |text_line|
        line = Line.new(text_line)
        if text_line[/[Рр]аунд ?\d/]
          @rounds << Round.new
        else
          @rounds.empty? ? @rounds << Round.new : @rounds.last.push_line(line)
        end
      end
    end

    def all_words
      rounds.inject([]) { |all_words, round| all_words << round.all_words }
    end

    def bad_words
      rounds.inject([]) { |bad_words, round| bad_words << round.bad_words }
    end
  end
end
