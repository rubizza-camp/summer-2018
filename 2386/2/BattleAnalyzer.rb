require 'terminal-table'
require_relative 'Participant'
require_relative 'ParticipantsStorage'
require_relative 'PopularWords'
require_relative 'ParticipantsNameLoader'

# Class that analyze battle
class BattleAnalyzer
  def process_participants(top_bad_words)
    show_top_participants(ParticipantsStorage.new, top_bad_words)
  end

  def partipicant_words(name, top_words = 30)
    names = ParticipantsNameLoader.new.participant_names
    if names.include? name
      puts PopularWords.new(ParticipantsStorage
                                .new.battles_by_name(name), top_words).count
    else
      puts "Я не знаю МЦ #{name}. Зато мне известны:"
      names.each { |participant| puts participant }
    end
  end

  def show_top_participants(participants, top_bad_words)
    rows = participants.participants.first(top_bad_words.to_i)
                       .map(&:participant_row)
    table = Terminal::Table.new rows: rows
    puts table
  end
end
