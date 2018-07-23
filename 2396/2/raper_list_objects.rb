# This is class RaperListObjects
class RaperListObjects
  attr_reader :list_rapers
  def initialize(data)
    @data        ||= data
    @list_rapers ||= fetch_rapers
  end

  private

  def fetch_rapers
    battles = BattleReader.new.battles_collection
    @data.map do |raper_name|
      Raper.new(raper_name,
                RaperListObjectsHelper.find_rapper_battles(battles, raper_name))
    end
  end
end
