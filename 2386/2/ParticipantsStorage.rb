require_relative 'ParticipantService'
require_relative 'FindModule'
# Participants Storage
class ParticipantsStorage
  include FindModule
  PATH_FOLDER = 'Rapbattle'.freeze
  attr_reader :participants
  def initialize
    @participants = []
    find_participants.each do |name|
      @participants.push(ParticipantService.new.add_participants(name))
    end
    @participants.sort_by! { |participant| participant.words[1] }.reverse!
  end

  def battles_by_name(name)
    @participants.find { |participant| participant.name == name }.battles
  end
end
