require 'russian_obscenity'
require 'terminal-table'
load 'participant.rb'
load 'modules.rb'

# Class parse for parsing data
class Parser
  PATH = File.expand_path('.').freeze
  attr_reader :participants, :methods
  def initialize(value, name)
    @participants = []
    @methods = create_methods
    create_participants(Dir[PATH + '/rap-battles/*'])
    @participants.sort_by! { |participant| participant.participant_data[:bad_words] }
    @participants.reverse!
    if name
      print_top_words(name, value)
    else
      print_obscene_participants(value)
    end
  end

  private

  def print_top_words(name, value)
    answer = participants.find { |participant| FunctionalMethods.name_check(participant.name, name) }
    if answer
      answer.count_words(value)
    else
      unknown_output(name)
    end
  end

  def unknown_output(name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    participants[0...3].each { |raper| puts raper.name }
  end

  def print_obscene_participants(value)
    rows = []
    @participants = @participants[0..value - 1] if value
    @participants.each { |participant| rows << participant.to_str }
    puts Terminal::Table.new rows: rows
  end

  def create_methods
    hash_methods = Hash.new(proc { |obj, data| obj.update_data(data) })
    hash_methods[nil] = proc { |*args| @participants << Participant.new(args[0], args[1]) }
    hash_methods
  end

  def create_participants(file_names)
    file_names.each do |file_name|
      name = FunctionalMethods.get_name(file_name)
      data = FunctionalMethods.get_data({}, file_name)
      check_participant(data, name)
    end
  end

  def check_participant(data, name)
    old_participant = participants.find { |participant| FunctionalMethods.name_check(participant.name, name) }
    methods[old_participant].call(old_participant ? old_participant : name, data)
  end
end
