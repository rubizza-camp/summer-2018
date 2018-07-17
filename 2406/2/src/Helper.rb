class Helper
  require 'terminal-table'

  def initialize
    indata_from_file = read_from_file('../data/Alias.config')
    @alias = []
    indata_from_file.each_with_index do |ally, index|
      @alias[index] = ally.gsub(/ { 2,}\n/, '')
    end
  end

  # Creation of new method not justified
  # This method smells of :reek:NestedIterators
  def self.check_arguments(args)
    include_in_valid_keys = false
    args.each do |arg|
      include_in_valid_keys = [BAD_WORDS_KEY, ARTIST_NAME_KEY, RANGE_KEY, PLAG_KEY, HELP_KEY].any? do |valid_key|
        arg.cover?(valid_key)
      end
    end
    include_in_valid_keys
  end

  def self.create_rows(base_of_artists, range)
    base_of_artists[0..range].each do |artist|
      row << [to_s(artist.name),
              "#{artist.get_battle_capacity} батлов",
              "#{artist.get_bad_words_capacity} нецензурных слов",
              "#{artist.get_words_in_battle_average} слов на баттл",
              "#{artist.get_words_in_round_average} слов в раунде"]
    end
    row
  end

  def self.create_table(base_of_artists, range)
    Terminal::Table.new do |row|
      row << create_rows(base_of_artists, range)
    end
  end

  def self.send_command(args)
    get_help if args.size == 1 && args.include?(HELP_KEY)
    bad_words(args[0].gsub("#{BAD_WORDS_KEY}=", '')) if args.size == 1 && args[0].cover?(BAD_WORDS_KEY)
  end

  def self.exclude_words(indata)
    indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
    indata = indata.split(' ').select { |each_word| each_word.length >= 4 }
    indata
  end

  def self.find_artist_name(name)
    @alias.each do |ally_name|
      if ally_name.split(';').include?(name)
        name = ally_name[0]
        break
      end
    end
    name
  end

  def self.read_from_buffer(buffer)
    parsed_text = ''
    buffer.each { |line| parsed_text += line if !line.include?('раунд') || !line.include?('Раунд') }
    parsed_text
  end

  def self.load_from_file(file)
    file.slice(FILE_NAME_LENGTH, read_from_file(file).length)
  end
end
