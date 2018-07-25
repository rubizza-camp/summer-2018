require_relative 'Battle'
require_relative 'Participant'
require_relative 'ParticipantsNameLoader'
require_relative 'BattleNameLoader'
# Storage Class with all participants
class ParticipantsStorage
  attr_reader :participants
  def initialize
    @participants = []
    ParticipantsNameLoader.new.participant_names.uniq.each do |name|
      @participants.push(Participant.new(name, battles_of_participant(name)))
    end
    @participants.sort_by!(&:bad_per_round).reverse!
  end

  def battles_by_name(name)
    @participants.find { |participant| participant.name == name }.battles
  end

  # :reek:UtilityFunction
  def battles_of_participant(name)
    battles = []
    BattleNameLoader.new(name).battle_names.each do |battle_name|
      battles.push(Battle.new(battle_name))
    end
    battles
  end
end
