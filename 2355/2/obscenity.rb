require 'russian_obscenity'
require './rapper.rb'
require './battle.rb'

# This class is needed to find and collect all obscenity from text files for one rapper
class Obscenity
  attr_reader :rapper

  def initialize(name)
    @rapper = Rapper.new(name)
    @mistakes = []
  end

  def initialize_mistakes
    File.new('./mistakes').each { |line| @mistakes << line.delete("\n") }
  end

  def delete_mistakes_from_stars(line)
    line.split.each do |word|
      @rapper.obscenity << word if word =~ /.*\*.*[А-Яа-я.,]$/
    end
  end

  def check_each_battle_for_star(number)
    Battle.new(@rapper.name, number).file.each do |line|
      delete_mistakes_from_stars(line)
    end
  end

  def first_check
    1.upto(@rapper.battle_count) do |number|
      check_each_battle_for_star(number)
    end
  end

  def delete_mistakes_from_rus_obs(word)
    @mistakes.each { |mis| @rapper.obscenity << word unless mis.casecmp(word) }
  end

  def rus_obs_line(line)
    RussianObscenity.find(line).each do |word|
      delete_mistakes_from_rus_obs(word)
    end
  end

  def check_each_battle_for_rus_obs(number)
    Battle.new(@rapper.name, number).file.each do |line|
      rus_obs_line(line)
    end
  end

  def check_rus_obs
    1.upto(@rapper.battle_count) do |number|
      check_each_battle_for_rus_obs(number)
    end
  end

  def check_battles_for_obscenity
    initialize_mistakes
    first_check
    check_rus_obs
  end
end
