require_relative 'name_checker'
require_relative 'create_data'
require_relative 'participant'
require 'terminal-table'

# Class for finding the most obscenes rapers
class ObsceneRapersFinder
  attr_reader :value, :rows, :participants

  def initialize(value, file_names)
    @value = value
    @participants = []
    @rows = []
    create_participants(file_names)
  end

  def run
    create_rows
    puts Terminal::Table.new rows: rows
  end

  private

  def create_rows
    sort_participants
    @participants = @participants[0..value - 1] if value
    @participants.each { |participant| @rows << participant.to_str }
  end

  def sort_participants
    @participants.sort_by! { |participant| participant.participant_data[:bad_words] }
    @participants.reverse!
  end

  def create_participants(file_names)
    file_names.each do |file_name|
      data = DataCreater.new(file_name).run
      name = data[:name]
      find_participant(name, data)
    end
  end

  def find_participant(name, data)
    old_participant = participants.find { |participant| NameChecker.new(participant.name, name).run }
    if old_participant
      old_participant.update_data(data)
    else
      create_participant(name, data)
    end
  end

  def create_participant(name, data)
    participant = Participant.new(name)
    participant.update_data(data)
    @participants << participant
  end
end
