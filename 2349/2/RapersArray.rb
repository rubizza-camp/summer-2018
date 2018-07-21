require_relative 'FormationParticipants'
require_relative 'Sum'
# In this class an array of participant data is generated for all battles:
# - name of participant
# - number of battles
# - bad words
# - bad words / number of battles
# - words in round
class RapersArray < FormationParticipants
  def self.battle_men_array
    @array = []
    name_comparison
    (0...choice_participant.length).step(1) do |line|
      @array << Sum.sum(@mens[line],
                        name_batlers.length).unshift(name_batlers[line])
    end
    @array
  end
end
