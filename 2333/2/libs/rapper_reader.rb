require_relative 'rapper.rb'

# The class that creates a rappers array
class RappersReader
  attr_reader :rappers
  def initialize
    @rappers = create_rappers_array
  end

  def create_rappers_array
    new_rappers_array = []
    json_of_rappers.each do |name, battles|
      new_rappers_array << Rapper.new(name, battles)
    end
    new_rappers_array
  end

  private

  def json_of_rappers
    JSON.parse(File.read('data.json'))
  end
end
