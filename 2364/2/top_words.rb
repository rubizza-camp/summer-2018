require_relative 'name_check.rb'

# Class fo printing top words
class TopWords
  attr_reader :value, :name, :participants
  def initialize(value, name, participants)
    @value = value
    @name = name
    @participants = participants
  end

  def print_top_words
    answer = participants.find { |participant| NameCheck.new(participant.name, name).name_check }
    if answer
      answer.count_words(value)
    else
      unknown_output
    end
  end

  def unknown_output
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    participants[0...3].each { |raper| puts raper.name }
  end
end
