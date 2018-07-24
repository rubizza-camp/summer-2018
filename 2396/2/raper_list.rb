# This is class RaperList
class RaperList
  attr_reader :names
  def initialize
    @names ||= rapers_names
  end

  private

  def rapers_names
    names = []
    Dir.chdir(BattleReader::FOLDER) do
      Dir.glob('*против*').map do |name|
        names.push(RaperListHelper.find_names(name))
      end
    end
    RaperListHelper.merge_similar_names(names.flatten.uniq)
  end
end
