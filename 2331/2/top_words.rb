require_relative './statistic.rb'
require 'pry'

class TopWords < Statistic
  attr_reader :amount, :name, :headings

  def initialize(options)
    @amount = options[:top_words] || 30
    @name = options[:name]
    @result = []
    @headings = %w[Word Frequency]
    super()
  end

  def print_result
    if data.key? @name
      prepare_result
      super(@result, @headings)
    else
      puts "Рэпер #{@name} не известен мне. Зато мне известны:"
      data.keys.each { |name| puts name }
    end
  end

  private

  def prepare_result
    occurrances(@name).first(@amount).each { |word, count_| @result << [word, count_] }
  end

  def occurrances(name)
    all_words = Helper.all_words(data[name]['battles'])
    occurrances = Hash.new(0)
    all_words.map(&:downcase).each do |word|
      Helper.preposition?(word) || occurrances[word] += 1
    end
    sort_words_by_frequency(occurrances)
  end

  def sort_words_by_frequency(occurrances)
    occurrances.sort_by { |_word, count_| count_ }.reverse.to_h
  end
end
