require_relative 'rapper_search'

module Statistics
  class TopWords
    include RapperSearch

    def self.call(rappers, name, number)
      TopWords.new(rappers, name, number).call
    end

    attr_reader :rappers, :name, :number

    def initialize(rappers, name, number)
      @rappers = rappers
      @name = name
      @number = number.to_i
    end

    def call
      rapper = rapper_by_name(rappers, name)
      show_popular_words(rapper) if rapper
    end

    private

    def show_popular_words(rapper)
      rapper.popular_words.sort_by(&:last).reverse.first(number).to_h.each do |word, count|
        puts "#{word.capitalize} - #{count} раз"
      end
    end
  end
end
