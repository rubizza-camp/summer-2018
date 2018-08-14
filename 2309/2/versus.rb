require 'pry'
require 'json'
require_relative 'parse_string.rb'
require_relative 'table_rating.rb'

# Class Input, processing input
class Input
  attr_reader :all_commands
  def initialize(user_commands)
    @user_commands = user_commands
  end

  def do_command
    @user_commands.each do |one_command|
      command = ParseString.new.split_one_command(one_command)
      all_commands(command[1].to_i)[command[0]]
    end
  end

  private
  def all_commands(parameter)
    @all_commands = {'--top-bad-words': (TableRating.new(parameter).create_table).to_json,
                     '--top-words': nil, '--name': nil}
  end
end

argument = ARGV
a = Input.new(argument)
a.do_command
