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
      Dir.glob('*против*' || '*vs*' || '*VS*').map { |title| Battle.new(title, File.read(title)) }
    end
  end

  def self.battlers_name
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob('*против*' || '*vs*' || '*VS*').map { |title| title.split('против' || 'vs' || 'VS').first.strip }.uniq
    end
  end
end
