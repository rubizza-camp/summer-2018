require_relative 'participant_name_loader'
require_relative 'participant'
require_relative 'battle'
# class Participant store
class ParticipantStore
  def initialize(battles_folder)
    @battles_folder = battles_folder
    @participants = {}
  end

  def top_by_bad_words(limit)
    participants.values.sort_by { |participant| - participant.bad_words_count }.first(limit)
  end

  private

  def participants
    if @participants.empty?
      Dir.glob("#{@battles_folder}/*") do |filename|
        next unless File.file?(filename)
        add_participant_from_file(filename)
      end
    end
    @participants
  end

  def add_participant_from_file(filename)
    original_name = ParticipantNameLoader.new(filename).participant_name
    battle = Battle.new(filename)
    participant = @participants[original_name]
    @participants[original_name] =
      if participant
        participant.add_battle(battle)
      else
        Participant.new(original_name, [battle])
      end
  end
end
