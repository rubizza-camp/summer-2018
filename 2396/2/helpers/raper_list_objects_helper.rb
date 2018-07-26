# This is module RaperListObjectsHelper
module RaperListObjectsHelper
  def self.find_rapper_battles(battles, raper_name)
    battles.select do |battle|
      battle.name.split('против').first.include? raper_name
    end
  end
end
