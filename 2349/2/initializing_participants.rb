# Documents with names and with expressions for search are opened
# This method smells of :reek:TooManyStatements
class InitializingParticipants
  attr_reader :part_choice, :batlers
  def initialize
    @part_choice = []
    @batlers = []
  end

  def choice_participant
    File.open('doc').each { |line| part_choice << line }
    part_choice
  end

  def name_batlers
    File.open('doc2').each { |line| batlers << line.chomp }
    batlers
  end
end
