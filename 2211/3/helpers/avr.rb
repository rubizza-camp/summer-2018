# Average

class Avr
  def initialize(all_rates)
    @all_rates = all_rates
    @article_score = 0
  end

  def avr
    @all_rates.each { |score| @article_score += score }
    @article_score /= @all_rates.size
    @article_score * 200 - 100
  end
end
