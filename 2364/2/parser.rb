require 'russian_obscenity'
require 'terminal-table'
require_relative 'participant.rb'
require_relative 'create_data.rb'
require_relative 'name_check.rb'
require_relative 'obscene_rapers.rb'
require_relative 'top_words.rb'

# Class parse for parsing data
class Parser
  PATH = File.expand_path('.').freeze
  attr_reader :participants, :methods
  def initialize
    @participants = []
    @methods = create_methods
    files_path = Dir[PATH + '/rap-battles/*']
    create_participants(files_path)
  end

  def call(name, value)
    if name
      TopWords.new(value, name, participants).print_top_words
    else
      ObsceneRapers.new(value, participants).print_obscene_participants
    end
  end

  private

  def create_methods
    hash_methods = Hash.new(proc { |obj, data| obj.update_data(data) })
    hash_methods[nil] = proc { |*args| @participants << Participant.new(args[0], args[1]) }
    hash_methods
  end

  def create_participants(file_names)
    file_names.each do |file_name|
      data = CreateData.new(file_name).take_data
      name = data[:name]
      check_participant(data, name)
    end
  end

  def check_participant(data, name)
    old_participant = participants.find { |participant| NameCheck.new(participant.name, name).name_check }
    methods[old_participant].call(old_participant ? old_participant : name, data)
  end
end
