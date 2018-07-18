# Counts average number of words per round
class TotalWordsInRoundCounter
  def self.count(battles)
    words = 0
    battles.each do |battle|
      words += Dir.chdir(INPUT_FOLDER) { File.read(battle) }.gsub(/[.!-?,:]/, ' ').strip.split.count
    end
    words / (battles.size * 3)
  end
end
