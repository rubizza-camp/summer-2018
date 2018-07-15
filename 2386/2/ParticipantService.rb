require_relative 'Counters'
require_relative 'Participant'

# :reek:UtilityFunction
# Participant Service
class ParticipantService
  PATH_FOLDER = 'Rapbattle'.freeze
  def add_participants(participant)
    participants_titles = find_participants_titles(participant)
    Participant.new(hash(participant, participants_titles))
  end

  def hash(participant, participants_titles)
    {
      name: participant,
      battles:  participants_titles.size,
      bad_words: bad_words(participant),
      bad_in_round: bad_in_round(participant, participants_titles),
      words_in_round: words_in_round(participant)
    }
  end

  def bad_words(participant)
    Counters.count_bad(find_participants_titles(participant))
  end

  def bad_in_round(participant, participants_titles)
    (bad_words(participant).to_f / participants_titles.size).round(2)
  end

  def words_in_round(participant)
    Counters.count_normal(find_participants_titles(participant))
  end

  def find_participants_titles(participant)
    participants_titles = []
    Dir.chdir(PATH_FOLDER) do
      Dir.glob("*#{participant}*").each do |title|
        participants_titles << title if title.split('против')
                                             .first.include? participant
      end
    end
    participants_titles
  end
end
