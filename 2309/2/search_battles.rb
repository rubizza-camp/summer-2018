require 'pry'
require_relative 'battle.rb'

# Class search battles
class SearchBattles
  attr_reader :list, :name
  def initialize(name_raper)
    @name = name_raper
    @list = []
    select_battles
  end

  LIST_ALL_BATTLES = Dir['rap-battles/*']

  def select_battles
    LIST_ALL_BATTLES.each do |file|
      name = file.split(/ против | vs /i).first.split('/').last.strip
      name == @name ? @list.push(battle(file)) : next
    end
  end

  def battle(title)
    @battle = Battle.new(title)
  end
end
