module DataRapers
  class Battle
    attr_reader :files, :rapers

    FOLDER        = 'rap-battles'.freeze
    FILE_PRONOUNS = 'pronouns.json'.freeze
    PRONOUNS      = JSON.parse(File.read(FILE_PRONOUNS))
    def initialize
      @files  ||= nil
      @rapers ||= {}
    end

    def rapers_all
      fetch_files
      handling_files
      fetch_rapers
    end

    def self.show_names_rapers
      rapers = Battle.new.rapers_all
      rapers.each_key { |key| puts key.capitalize }
    end

    # This method smells of :reek:UtilityFunction
    def self.clearing_text_from_garbage(text)
      arr_words = text.delete(",.!?\"\':;«»").split(' ')
      arr_words = arr_words.select! { |word| word.size > 3 }
      arr_words - PRONOUNS
    end

    private

    def fetch_rapers
      rapers.each_key { |key| handling_name(key) }
      rapers
    end

    def handling_files
      @files.each do |file_name|
        handling_file(file_name)
      end
    end

    def handling_file(file_name)
      file_name.split(/\sпротив|\svs/i, 2).each do |name|
        new_name = name.strip.gsub(/\(.*\)/, '').strip.upcase
        write_to_hash(new_name, file_name) unless new_name.empty?
      end
    end

    def write_to_hash(name, file_name)
      full_file_name = "#{FOLDER}/#{file_name}"
      rapers[name] ||= []
      rapers[name].push(full_file_name)
    end

    def handling_name(key_search)
      rapers.each_key do |key|
        if key_search =~ /#{Regexp.escape(key)}/ && key != key_search
          processing_duplicate_names(key, key_search)
          return true
        end
      end
    end

    def processing_duplicate_names(key_one, key_second)
      tmp_value = rapers[key_one] + rapers[key_second]
      rapers[key_one] = tmp_value
      rapers.delete(key_second)
    end

    def fetch_files
      @files = Dir.entries(FOLDER).reject do |file|
        File.directory? file
      end
    end
  end
end
