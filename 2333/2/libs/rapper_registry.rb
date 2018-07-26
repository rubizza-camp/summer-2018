# The class that search rappers in array of rappers
class RapperRegistry
  def initialize(rappers)
    @rappers = rappers
  end

  def select_rapper(name)
    @rappers.select { |rapper| rapper.name == name }
  end

  def search_name(name)
    names.include?(name)
  end

  def names
    @rappers.map(&:name)
  end
end
