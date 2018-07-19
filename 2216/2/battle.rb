class Battle
  attr_reader :rapper

  def initialize(participant_name)
    @rapper = participant_name
  end

  def titles
    battles_hash = {}
    read_battles(battles_hash)
    battles_hash
  end

  def self.right_battle?(file_name, rapper)
    file_name[file_name.index('/') + 1..-1].strip.index(rapper) &&
      file_name[file_name.index('/') + 1..-1].strip.index(rapper).zero?
  end

  private

  def read_battles(battles_hash)
    file_names = Dir['rap-battles/*']
    file_names.each do |file_name|
      read_separate_battle(file_name, battles_hash) if Battle.right_battle?(file_name, @rapper)
    end
  end

  def read_separate_battle(file_name, battles_hash)
    battle_file = File.open(file_name, 'r')
    content = battle_file.read
    battles_hash[file_name] = content.tr("\n", ' ')
    battle_file.close
  end
end
