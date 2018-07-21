require_relative 'InitializingParticipants'
# -Open the catalog
# - Look for a file name with a regular expression
# - if appropriate, we accumulate information
class FormationParticipants < InitializingParticipants
  def self.name_comparison
    @mens = Array.new(choice_participant.length, [])
    Dir.glob('**versus/*') do |fl|
      (0...choice_participant.length).step(1) do |count|
        @mens[count] += ProcessingParticipant.processing_participant_file(fl) if
        fl =~ /#{choice_participant[count].chomp.to_s}/
      end
    end
  end
end
