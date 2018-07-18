class Helper
  require 'terminal-table'

  def self.load_alias_list
    indata_from_file = HelperDAO.read_from_file('../data/Alias.config')
    alias_name = []
    indata_from_file.each_with_index do |ally, index|
      alias_name[index] = ally.gsub(/ { 2,}\n/, '')
    end
  end

  # Creation of new method not justified
  # This method smells of :reek:NestedIterators
  def self.check_arguments(args)
    include_in_valid_keys = false
    args.each do |arg|
      include_in_valid_keys = [BAD_WORDS_KEY, ARTIST_NAME_KEY, RANGE_KEY, PLAG_KEY, HELP_KEY].any? do |valid_key|
        arg.include?(valid_key)
      end
    end
    include_in_valid_keys
  end

  def self.create_rows(row, base_of_artists, range)
    base_of_artists[0..range].each do |artist|
      row << [artist.name.to_s,
              "#{artist.battle_capacity} батлов",
              "#{artist.bad_words_capacity} нецензурных слов",
              "#{artist.words_in_battle_average} слов на баттл",
              "#{artist.words_in_round_average} слов в раунде"]
    end
    row
  end

  def self.create_table(base_of_artists, range)
    Terminal::Table.new do |row|
      create_rows(row, base_of_artists, range)
    end
  end

  def self.send_command(args)
    help if args.size == 1 && args.include?(HELP_KEY)
    bad_words(args[0].gsub("#{BAD_WORDS_KEY}=", '')) if args.size == 1 && args[0].include?(BAD_WORDS_KEY)
  end

  def self.exclude_words(indata)
    indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
    indata = indata.split(' ').select { |each_word| each_word.length >= 4 }
    indata
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
