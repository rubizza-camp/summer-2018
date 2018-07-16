class WordsInRoundCounter
  def self.count(battles, battler_name, count_of_battles)
    words = 0
    battles.each do |battle|
      if battle.title.split('против').first.include? battler_name
        words += battle.text.gsub(/[.!-?,:]/, ' ').strip.split.count
      end
    end
    words / (count_of_battles * 3)
  end
end
