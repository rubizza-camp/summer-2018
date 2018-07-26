require './word'
require './lyrics'
require './stats'

# this class provides all info about rapper
class Rapper
  attr_reader :stats, :name, :overall, :battles

  def initialize(name, all_battles_paths)
    @name = name
    @battles = []
    @overall = {}
    collect_rapper_battles_from(all_battles_paths)
    collect_overall
    @stats = Stats.new(self)
  end

  def collect_rapper_battles_from(all_battles_paths)
    @battles = all_battles_paths.select { |battle_path| battle_path.split(/( против | vs )/i).first.include?(@name) }
  end

  def collect_overall
    overall[:battles_num] = @battles.size
    rounds = rapper_rounds
    overall[:rounds_num] = rounds.zero? ? 1 : rounds
  end

  def rapper_rounds
    @battles.map { |battle_file_path| Battle.new(battle_file_path).rounds_count }.count
  end
end
