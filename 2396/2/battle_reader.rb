# This is class BattleReader
class BattleReader
  FOLDER = 'rap-battles'.freeze
  attr_reader :battles_collection
  def initialize
    @battles_collection ||= declaim
  end

  private

  def declaim
    Dir.chdir(FOLDER) do
      Dir.glob('*против*').map { |name| Battle.new(name, File.read(name)) }
    end
  end
end
