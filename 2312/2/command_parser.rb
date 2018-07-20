# this class here only because of reek.
class Command
  def initialize(command, parameter)
    @command = command
    @parameter = parameter
  end

  def top_bad
    @parameter.to_i if @command.include?('--top-bad-words=')
  end

  def top_words
    @parameter.to_i if @command.include?('--top-words=')
  end

  def name
    @parameter if @command.include?('--name=')
  end
end

# this class parses commands and decides, what to do
class CommandParser
  attr_reader :to_do
  def initialize
    @to_do = { top_bad_words: 0, top_words: 0, name: '' }
    @arguments = ARGV
    parse_commands
  end

  private

  def parse_commands
    @arguments.each do |command|
      command_obj = Command.new(command, command.split('=')[1])
      look_for_top_bad_words_arg(command_obj)
      look_for_top_words_arg(command_obj)
      look_for_name_arg(command_obj)
    end
  end

  def look_for_top_bad_words_arg(command_obj)
    @to_do[:top_bad_words] = command_obj.top_bad
  end

  def look_for_top_words_arg(command_obj)
    @to_do[:top_words] = command_obj.top_words
  end

  def look_for_name_arg(command_obj)
    @to_do[:name] = command_obj.name
  end
end
