# Avr

class Avr
  def initialize(all_rates)
    @all_rates = all_rates
    @article_acore = 0
  end

  def avr
    @all_rates.each { |score| @article_acore += score }
    @article_acore /= @all_rates.size
    @article_acore * 200 - 100
  end
end
