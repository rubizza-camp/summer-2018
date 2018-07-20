module DirectoryHelper
  BATTLE_LOC = 'Battle_txt'.freeze
  # getting the names of all battlers
  def self.take_all_battles
    list = nil
    Dir.chdir(BATTLE_LOC) { list = Dir.glob('*против*') }
  end

  # getting text of the battler
  def self.take_text_battler(file_name)
    File.read("#{BATTLE_LOC}/#{file_name}")
  end
end
