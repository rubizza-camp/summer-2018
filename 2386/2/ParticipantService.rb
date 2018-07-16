require_relative 'Counters'
require_relative 'Participant'

# :reek:UtilityFunction
# Participant Service
class ParticipantService
  PATH_FOLDER = 'Rapbattle'.freeze
  def add_participants(participant)
    participants_titles = find_participants_titles(participant)
    Participant.new(
      name: participant,
      battles:  participants_titles.size,
      bad_words: bad_words(participant),
      bad_in_round: bad_in_round(participant, participants_titles),
      words_in_round: words_in_round(participant)
    )
  end

  def bad_words(participant)
    Counters.count_bad(find_participants_titles(participant))
  end

  def bad_in_round(participant, participants_titles)
    (bad_words(participant).to_f / participants_titles.size)
  end

  def words_in_round(participant)
    Counters.count_normal(find_participants_titles(participant))
  end

  def find_participants_titles(participant)
    Dir.chdir(PATH_FOLDER) do
      Dir.glob("*#{participant}*").each_with_object([]) do |title, array_files|
        array_files << title if title.split('против')
                                     .first.include?(participant)
      end
    end
  end
end
