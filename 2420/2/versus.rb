# :reek:FeatureEnvy

# class Battler
class Battler
  Dir.chdir('/home/polia/summer-2018/2420/2/')
  FOLDER_PATH = Dir.pwd
  VERSUS = /\bvs\b|\bVS\b|\bпротив\b/
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.battler_names_list
    files = Dir.entries("#{FOLDER_PATH}/Texts/").reject { |file_name| File.directory?(file_name) }
    name_battlers = files.map { |all_file_names| all_file_names.lstrip.split(VERSUS).first }
    name_battlers.uniq
  end

  def all_battles
    Dir.chdir("#{FOLDER_PATH}/Texts/")
    @all_battles ||= Dir.glob([" #{name}*", "#{name}*"])
  end

  def battles_count
    @battles_count ||= all_battles.count
  end

  def all_battles_text
    text = ''
    all_battles.each do |file_name|
      text << IO.read("#{FOLDER_PATH}/Texts/#{file_name}")
    end
    text.gsub!(/^\s+|\n|\r|\s+$|-|–/, ' ')
  end

  def all_battles_words_count
    all_battles_text.split.count
  end

  def bad_words
    @bad_words ||= File.read("#{FOLDER_PATH}/bad_words").split(' ')
  end

  def bad_words_count
    sum_bad_words = 0
    bad_words.each do |bad_word|
      sum_bad_words += all_battles_text.gsub(bad_word).count
    end
    sum_bad_words
  end

  def words_in_battle
    @words_in_battle ||= all_battles_words_count / battles_count
  end

  def words_in_raund
    @words_in_raund ||= all_battles_words_count / (battles_count * 3)
  end

  def text_without_preposition
    all_texts = all_battles_text.downcase!
    prepositions_list = File.read("#{FOLDER_PATH}/prepositions").split(',')
    prepositions_list.each do |preposition|
      all_texts.gsub!(/#{preposition}[аояиеёю ]/, '')
    end
    all_texts
  end
end
