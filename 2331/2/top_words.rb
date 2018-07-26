require_relative './statistic.rb'

class TopWords < Statistic
  HEADINGS = %w[Word Frequency].freeze
  DEFAULT_AMOUNT = 30

  attr_reader :amount, :name, :headings

  def initialize(options)
    @amount = options[:top_words] || DEFAULT_AMOUNT
    @name = options[:name]
    @result = []
    super()
  end

  def print_result
    if data.key? @name
      prepare_result
      super(@result, HEADINGS)
    else
      puts "Рэпер #{@name} не известен мне. Зато мне известны:"
      data.keys.each { |name| puts name }
    end
  end

  private

  def prepare_result
    occurrences(@name).first(@amount).each { |word, count_| @result << [word, count_] }
  end

  def occurrences(name)
    all_words = Helper.all_words(data[name]['battles'])
    occurrences = Hash.new(0)
    all_words.map(&:downcase).each do |word|
      Helper.preposition?(word) || occurrences[word] += 1
    end
    sort_words_by_frequency(occurrences)
  end

  def sort_words_by_frequency(occurrences)
    occurrences.sort_by { |_word, count_| count_ }.reverse.to_h
  end
end
