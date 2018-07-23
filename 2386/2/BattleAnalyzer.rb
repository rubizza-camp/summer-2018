require 'terminal-table'
require 'pry'
require_relative 'Participant'
require_relative 'Counters'
require_relative 'ParticipantService'
require_relative 'PopularWords'
require_relative 'ParticipantsStorage'
require_relative 'FindModule'

# Main logic class
class BattleAnalyzer
  include FindModule
  PATH_FOLDER = 'Rapbattle'.freeze
  def process_participants(top_bad_words)
    show_top_participants(ParticipantsStorage.new, top_bad_words)
  end

  def partipicant_words(name, top_words = 30)
    if find_participants.include?(name)
      PopularWords.new.sort_hash(name).reverse[0...top_words.to_i].to_h
                  .each do |word, count|
        puts "#{word} - #{count} раз"
      end
    else
      puts "Я не знаю МЦ #{name}. Зато мне известны:"
      find_participants.each { |battler| puts battler }
    end
  end

  private

  def show_top_participants(participants, top_bad_words)
    rows = participants.participants.first(top_bad_words.to_i)
                       .map do |participant|
      Participant
        .get_participant_row(participant)
    end
    table = Terminal::Table.new rows: rows
    puts table
  end
end
