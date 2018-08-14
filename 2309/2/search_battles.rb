require 'pry'
require_relative 'battle.rb'

# Class search battles
class SearchBattles
  attr_reader :list, :name
  def initialize(name)
    @name = name
    @list = []
  end

  def count_battles
    LIST_ALL_BATTLES.each do |file|
      name = file.split(/ против | vs /i).first.split('/').last.strip
      name == @name ? @list.push(Battle.new(file)) : next
    end
  end

  private
  LIST_ALL_BATTLES = Dir['rap-battles/*']
end
