# Class contain names of battles foe one participant
class BattleNameLoader
  PATH_FOLDER = 'Rapbattle'.freeze
  attr_reader :battle_names
  def initialize(name)
    find_names(name)
  end

  def find_names(participant)
    @battle_names = Dir.chdir(PATH_FOLDER) do
      Dir.glob("*#{participant}*").each_with_object([]) do |title, files|
        files << title if title.split('против')
                               .first.include?(participant)
      end
    end
  end
end
