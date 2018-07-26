# Base command pattern
# This class smells of :reek:Attribute
# This class smells of :reek:MissingSafeMethod
class BaseCommand
  attr_accessor :reader, :writer

  def initialize(reader, writer)
    @reader = reader
    @writer = writer
  end

  # This method smells of :reek:MissingSafeMethod
  def run!
    reader.read
    execute
    writer.write(presenter)
  end

  def execute
    raise NotImplemented
  end

  def presenter
    raise NotImplemented
  end
end
