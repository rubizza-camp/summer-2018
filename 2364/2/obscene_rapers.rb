# Class for finding the most obscenes rapers
class ObsceneRapers
  attr_reader :value, :rows, :participants
  def initialize(value, participants)
    @value = value
    @participants = participants
    @rows = []
  end

  def print_obscene_participants
    create_rows
    puts Terminal::Table.new rows: rows
  end

  def create_rows
    sort_participants
    @participants = @participants[0..value - 1] if value
    @participants.each { |participant| @rows << participant.to_str }
  end

  def sort_participants
    @participants.sort_by! { |participant| participant.participant_data[:bad_words] }
    @participants.reverse!
  end
end
