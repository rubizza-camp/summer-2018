require_relative 'name_checker'
require_relative 'count_words'

# Class fo printing top words
class TopWordsFinder
  attr_reader :value, :argument_name, :participant

  def initialize(value, name, file_names)
    @value = value
    @argument_name = name
    @participant = nil
    create_participant(file_names)
  end

  def run
    if participant
      WordsCounter.new(participant.all_texts, value).run
    else
      puts "Рэпер #{argument_name} не известен мне. Зато мне известны:\nRickey F\nOxxxymiron\nГалат"
    end
  end

  private

  def create_participant(file_names)
    file_names.each do |file_name|
      text = File.read(file_name)
      name = NameParser.new(file_name).run
      update_participant_text(name, text)
    end
  end

  def update_participant_text(name, text)
    check = NameChecker.new(argument_name, name).run
    @participant ||= Participant.new(name) if check
    @participant.update_text(text) if participant && check
  end
end
