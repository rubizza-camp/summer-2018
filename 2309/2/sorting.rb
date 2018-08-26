require_relative 'raper.rb'

# Class Sorting
class Sorting
  def initialize(sorting_data, output_quantity)
    @sorting_data = sorting_data
    @output_quantity = output_quantity
  end

  def sorting_elements
    @sorting = @sorting_data.sort_by { |element| - perform_method(raper_bad_words(element)) }.first(@output_quantity)
  end

  def perform_method(method)
    method
  end

  def raper_bad_words(raper)
    @raper_bad_words = raper.bad_words
  end
end
