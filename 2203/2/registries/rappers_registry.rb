# Registry.instance.find_or_create_by_name()
# This class smells of :reek:Attribute
class RapperRegistry
  attr_accessor :rappers

  # singleton pattern
  def self.instance
    @instance ||= new
  end

  def initialize
    @rappers = []
  end

  def find_or_create_by_name(name)
    find_by_name(name) || @rappers << Rapper.new(name)
  end

  # This method smells of :reek:UncommunicativeVariableName
  def find_by_name(name)
    @rappers.find { |r| r.name == name }
  end
end
