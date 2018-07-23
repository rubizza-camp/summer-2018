# This is class BattleReader
class BattleReader
  attr_reader :battles_collection
  def initialize
    @battles_collection ||= declaim
  end

  private

  def declaim
    Dir.chdir(Battle::FOLDER) do
      Dir.glob('*против*').map { |name| Battle.new(name, File.read(name)) }
    end
  end
end
