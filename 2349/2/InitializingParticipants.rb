# Documents with names and with expressions for search are opened
# This method smells of :reek:TooManyStatements
class InitializingParticipants
  def self.choice_participant
    @part_choice = []
    begin
      participant_file = File.open('doc')
    rescue Errno::ENOENT => ex
      abort ex.message
    end
    participant_file.each { |line| @part_choice << line }
    participant_file.close
    @part_choice
  end

  # This method smells of :reek:TooManyStatements
  def self.name_batlers
    name_batlers = []
    begin
      name_bat = File.open('doc2')
    rescue  Errno::ENOENT => ex
      abort ex.message
    end
    name_bat.each { |line| name_batlers << line.chomp unless line == '' }
    name_bat.close
    name_batlers
  end
end
