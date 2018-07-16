class WordsInRoundCounter
  BATTLES_FOLDER = 'Battles'.freeze
  def self.count(battles)
    words = 0
    battles.each do |battle|
      words += Dir.chdir(BATTLES_FOLDER) { File.read(battle) }.gsub(/[.!-?,:]/, ' ').strip.split.count
    end
    words / (battles.size * 3)
  end
end
