# rubocop:disable Layout/Tab
# :reek:FeatureEnvy

class Battler
  FOLDER_PATH = '/home/polia/summer-2018/2420/2/'.freeze
  attr_reader :name

  def initialize(name)
				@name = name
  end

  def self.battler_names_list
    files = Dir.entries(FOLDER_PATH).reject { |file_name| File.directory?(file_name) || file_name[0].include?('.') }
    name_battler = files.map { |all_file_names| all_file_names.lstrip.split(/\bvs\b|\bVS\b|\bпротив\b/).first }
    name_battler.uniq
  end

  def find_battles
    Dir.chdir(FOLDER_PATH)
    Dir.glob([" #{name}*", "#{name}*"])
  end

  def battles_count
    find_battles.count
  end

  def all_battles_text
    text = ''
    find_battles.each do |file_name|
						text << IO.read("#{FOLDER_PATH}#{file_name}")
    end
    text.gsub!(/^\s+|\n|\r|\s+$|-|–/, ' ')
  end

  def all_battles_words_count
    all_battles_text.split.count
  end

  def bad_words_count
    bad_words = File.read("#{FOLDER_PATH}bad_words").split(' ')
    sum_bad_words = 0
    bad_words.each_index do |index|
    		sum_bad_words += all_battles_text.gsub(bad_words[index]).count
    end
    sum_bad_words
  end

  def words_in_battle
    all_battles_words_count / battles_count
  end

  def words_in_raund
    all_battles_words_count / (battles_count * 3)
  end

  def text_without_preposition
    all_texts = all_battles_text.downcase!
    prepositions_list = File.read("#{FOLDER_PATH}prepositions").split(',')
    prepositions_list.each do |preposition|
  	   all_texts.gsub!(/#{preposition}[аояиеёю ]/, '')
  	 end
    all_texts
  end
end

# rubocop:enable Layout/Tab
