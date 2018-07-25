require_relative 'rapper.rb'

# Class that creates a rappers array
class RapperRegistry
  attr_reader :rappers
  def initialize
    @rappers = create_rappers_array
  end

  def select_rapper(name)
    rappers.select { |rapper| rapper.name == name }
  end

  def search_name(name)
    names.include?(name)
  end

  def names
    @rappers.map(&:name)
  end

  private

  def create_rappers_array
    new_rappers_array = []
    versus_json = JSON.parse(File.read('data.json'))
    versus_json.each do |name, battles|
      new_rappers_array << Rapper.new(name, battles)
    end
    new_rappers_array
  end
end
