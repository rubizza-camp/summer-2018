require_relative 'rap_battle.rb'
require_relative 'battler.rb'

# Contains all methods without instance
module ReadFromFile
  def self.sorted_battlers
    battlers.sort_by!(&:number_of_bad_words).reverse
  end

  def self.battlers
    battlers_name.map { |battler_name| Battler.new(battler_name, battles) }
  end

  def self.battles
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob('*против*').map { |title| Battle.new(title, File.read(title)) }
    end
  end

  def self.battlers_name
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob('*против*').map { |title| title.split('против').first.strip }.uniq
    end
  end
end

module BattlerAsRow
  # This method smells of :reek:DuplicateMethodCall
  def self.get_battler_as_row(battler)
    row = []
    row += [battler.name.to_s]
    row += ["#{battler.number_of_battles} баттлов", "#{battler.number_of_bad_words} нецензурных слов"]
    row += ["#{battler.bad_words_per_round} слова на баттл", "#{battler.average_number_of_words} слов в раунде"]
    row
  end
end
