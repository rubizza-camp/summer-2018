require_relative 'Counters'
require_relative 'Participant'
require_relative 'FindModule'
# Participant Service
class ParticipantService
  include FindModule
  PATH_FOLDER = 'Rapbattle'.freeze
  def add_participants(participant)
    participants_titles = find_participants_titles(participant)
    Participant.new(
      name: participant,
      battles:  participants_titles,
      bad_words: bad_words(participant),
      bad_in_round: bad_in_round(participant, participants_titles),
      words_in_round: words_in_round(participant)
    )
  end

  def bad_words(participant)
    Counters.count_bad(find_participants_titles(participant))
  end

  def bad_in_round(participant, participants_titles)
    bad_words(participant).to_f / participants_titles.size
  end

  def words_in_round(participant)
    Counters.count_normal(find_participants_titles(participant))
  end
end
