require_relative 'participant_name_loader'
require_relative 'participant'
require_relative 'battle'
# class Participant store
class ParticipantStore
  def initialize(battles_folder)
    @battles_folder = battles_folder
  end

  def top_by_bad_words(limit)
    participants.values.sort_by { |participant| - participant.bad_words_count }.first(limit)
  end

  private

  def participants
    @participants ||= Dir.glob("#{@battles_folder}/*").each_with_object({}) do |filename, participants_store|
      next unless File.file?(filename)
      original_name = ParticipantNameLoader.new(filename).participant_name
      participant = participants_store[original_name] ||= Participant.new(original_name)
      participant.add_battle(Battle.new(filename))
    end
  end
end
