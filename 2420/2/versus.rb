# :reek:FeatureEnvy
# class Battler
class Battler
  FOLDER_PATH = Dir.pwd.freeze
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

  def all_battles_text
    text = ''
    all_battles.each do |file_name|
      text << IO.read("#{FOLDER_PATH}/Texts/#{file_name}")
    end
    text.gsub!(/^\s+|\n|\r|\s+$|-|–|,|\.|!|\?|&quot|:|;|\)|\(/, '') # \*
  end

  def all_information_about_battler
    count = BadWordsCounter.new(all_battles_text).run
    { name:            name,
      bad_words_count: count,
      battles_count:   battles_count,
      words_in_raund:  words_in_raund,
      words_in_battle: words_in_battle }
  end

  private

  def all_battles
    Dir.chdir("#{FOLDER_PATH}/Texts/")
    @all_battles ||= Dir.glob([" #{name}*", "#{name}*"])
  end

  def battles_count
    @battles_count ||= all_battles.count
  end

  def words_in_battle
    @words_in_battle ||= all_battles_words_count / battles_count
  end

  def words_in_raund
    @words_in_raund ||= all_battles_words_count / (battles_count * 3)
  end

  def all_battles_words_count
    all_battles_text.split.count
  end
end
