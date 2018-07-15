require 'terminal-table'
require_relative 'Participant'
require_relative 'Counters'
require_relative 'ParticipantService'
require_relative 'PopularWords'

# :reek:TooManyStatements
# :reek:UtilityFunction
# Main logic class
class BattleAnalizer
  PATH_FOLDER = 'Rapbattle'.freeze
  def process_participants(top_bad_words)
    participants = []
    find_participants.each do |name|
      participants << ParticipantService.new.add_participants(name)
    end
    participants.sort_by!(&:bad_in_round).reverse!
    show_top_participants(participants, top_bad_words)
  end

  def partipicant_words(name, top_words = 30)
    if find_participants.include? name
      words = PopularWords.new
      list = words.sort_hash(name).reverse[0...top_words.to_i].to_h
      list.each do |word, count|
        puts "#{word} - #{count} раз"
      end
    else
      puts "Я не знаю МЦ #{name}. Зато мне известны:"
      find_participants.each { |battler| puts battler }
    end
  end

  private

  def find_participants
    participants = []
    Dir.chdir(PATH_FOLDER) do
      Dir.glob('*против*').each do |title|
        participants << title.split('против').first.strip
      end
    end
    participants.uniq
  end

  def show_top_participants(participants, top_bad_words)
    rows = []
    top_bad_words.to_i.times do |ind|
      rows << get_participant_as_row(participants[ind])
    end
    table = Terminal::Table.new rows: rows
    puts table
  end

  def get_participant_as_row(participant)
    row = [participant.name, "#{participant.battles} батлов"]
    row += ["#{participant.bad_words} нецензурных слов"]
    row += ["#{participant.bad_in_round} слов на батл"]
    row + ["#{participant.words_in_round} слов в раунде"]
  end
end
