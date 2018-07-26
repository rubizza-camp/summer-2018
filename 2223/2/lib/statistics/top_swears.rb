require 'terminal-table'

module Statistics
  class TopSwears
    DEFAULT_NUMBER_SWEARS = 30

    def self.call(rappers, number)
      TopSwears.new(rappers, number).call
    end

    attr_reader :rappers, :number

    def initialize(rappers, number = DEFAULT_NUMBER_SWEARS)
      @rappers = rappers
      @number = number
    end

    def call
      top_rappers = rappers.sort_by(&:bad_words_for_battle).reverse.first(number.to_i)
      puts Terminal::Table.new(rows: top_rappers.map(&:information))
    end
  end
end
