require_relative 'counters'

# The class Raper is responsible for models of rapers wich a saved and processed later
# This method smells of :reek:TooManyInstanceVariables
# Disable reek on this class becouse on my opinion in that example are not many variables

class Raper
  include Counters
  attr_reader :name, :titles
  def initialize(name_of_raper)
    @name = name_of_raper
    @titles = find_rapers_titles
  end

  def battles
    @battles ||= find_rapers_titles.size
  end

  def bad_in_round
    @bad_in_round ||= (bad_words.to_f / @titles.size).round(2)
  end

  def bad_words
    @bad_words ||= count_bad
  end

  def words_in_round
    @words_in_round ||= count_normal(@titles)
  end

  def self.add_raper(name_of_raper)
    Raper.new(name_of_raper)
  end

  # This method smells of :reek:UtilityFunction
  # I think it will be better to paste this code here in couse of small project
  def find_rapers_titles
    rapers_titles = []
    Dir.chdir(Service::PATH) do
      Dir.glob("*#{@name}*").each do |title|
        rapers_titles << title if title.split('против').first.include? @name
      end
    end
    rapers_titles
  end
end
