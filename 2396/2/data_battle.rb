require 'json'

# Fetch data about battles
class DataBattle
  FOLDER        = 'rap-battles'.freeze
  FILE_PRONOUNS = 'pronouns.json'.freeze
  PRONOUNS      = JSON.parse(File.read(FILE_PRONOUNS))

  attr_reader :rapers

  def initialize
    @rapers = {}
    @files  = []
  end

  def fetch_rapers
    handling_files
    rapers.each_key { |key| handling_name(key) }
  end

  def self.fetch_files_one_raper(name)
    Dir.glob("#{FOLDER}/*#{name}*").reject do |file|
      File.directory? file
    end
  end

  def self.clearing_text_from_garbage(text)
    arr_words = text.delete(",.!?\"\':;«»").split(' ')
    arr_words = arr_words.select! { |word| word.size > 3 }
    arr_words - PRONOUNS
  end

  private

  def handling_files
    fetch_files_all
    @files.each do |file_name|
      handling_file(file_name)
    end
  end

  def handling_file(file_name)
    full_file_name = "#{FOLDER}/#{file_name}"
    file_name.split(/\sпротив|\svs/i, 2).each do |name|
      new_name = name.strip.gsub(/\(.*\)/, '').strip.upcase
      unless new_name.empty?
        rapers[new_name] ||= []
        rapers[new_name].push(full_file_name)
      end
    end
  end

  def handling_name(key_search)
    rapers.each_key do |key|
      if key_search =~ /#{Regexp.escape(key)}/i && key != key_search
        processing_duplicate_names(key, key_search)
        return true
      end
    end
  end

  def processing_duplicate_names(key_one, key_second)
    tmp_value = rapers[key_one] + rapers[key_second]
    @rapers[key_one] = tmp_value
    @rapers.delete(key_second)
  end

  def fetch_files_all
    @files = Dir.entries(FOLDER).reject do |file|
      File.directory? file
    end
  end
end
