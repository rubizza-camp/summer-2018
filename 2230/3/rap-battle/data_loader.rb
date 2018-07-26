require './file_reader.rb'

class DataLoader
  attr_reader :result

  def initialize
    @result = []
  end

  def load_data
    @result = build_data
  end

  private

  def rappers_list
    @rappers_list ||= Utils.rappers_list
  end

  # Generate list of files
  def build_file_list(folder)
    Dir.entries(folder).reject { |file_name| File.directory? file_name }
  end

  # parse list of files
  # :reek:TooManyStatements
  def get_file_list(name)
    common_file_list = build_file_list('data')
    file_list = []
    # filter rapper names by name
    names = Utils.escape_string(rappers_list.grep(/#{Utils.escape_string(name)}/)[0].gsub(', ', '|'))
    common_file_list.grep(/#{names}/i).each do |file_name|
      file_list << "#{file_name}\n" if file_name.sub(/\s(прот|vs|VS ).+/, '').index(/#{names}/)
    end
    file_list
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # :reek:TooManyStatements
  def build_data
    rappers_list.inject([]) do |data, rapper_name|
      rapper_name = rapper_name.sub(/,.*/, '')
      files = get_file_list(rapper_name)
      text = FileReader.new.read(files)
      battles_count = files.size
      words_count = text.scan(/\S+/).size
      bad_words_count = RussianObscenity.find(text).size
      words_per_battle = bad_words_count.fdiv(battles_count).round(2)
      words_per_stage = words_count.fdiv(battles_count).fdiv(3).round(0)
      data << {
        name:             rapper_name,
        text:             text,
        battles_count:    battles_count,
        words_count:      words_count,
        bad_words_count:  bad_words_count,
        words_per_battle: words_per_battle,
        words_per_stage:  words_per_stage
      }
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
