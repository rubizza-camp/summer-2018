# - received the current file from the directory
# - sorting with the help of regular expressions of bad words
class ProcessingParticipant
  # This method smells of :reek:TooManyStatements
  def self.raper_file_open(file)
    participant_file = File.open(file)
    # Total number of words in the battles and obscene words in the battles
    participant_file.each do |line|
      @total_words += line.split(/[а-яА-Яa-zA-Z0-9_]{2,}/)
      @text_battle += line.split(/[^а-яА-Яa-zA-Z]/)
      @bad_words << line[/ебал(у|а|о)|бля| бл(я|[*])(д|т)ь|е(б|[*])л(а|о)(н|м)/]
    end
    participant_file.close
  end

  # This method smells of :reek:TooManyStatements
  def self.processing_participant_file(file)
    total_words_array = []
    @bad_words = []
    @total_words = []
    @text_battle = []
    raper_file_open(file)
    total_words_count = @total_words.length
    text_battle_no_empty = @text_battle.reject { |col| col == '' }
    total_words_array.push(total_words_count / 3, @bad_words.compact.length,
                           text_battle_no_empty)
  end
end
