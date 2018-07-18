class Helper
  require 'terminal-table'

  VALID_KEY_COLLECTION = [BAD_WORDS_KEY, ARTIST_KEY, RANGE_KEY, PLAG_KEY, HELP_KEY].freeze

  def self.artist_exist(args)
    HelperDAO.artist_list.each do |artist_base|
      return true if args.join('') == artist_base.name.delete(' ')
    end
    false
  end

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
    args.each do |arg|
      return true unless arg.include?(ARTIST_KEY)
      return false unless VALID_KEY_COLLECTION.any? { |valid_key| arg.include?(valid_key) }
    end
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

  # That disable need, because it's command method and use like some kind of entrypoint. Decomposition is not recomended
  # rubocop:disable Metrics/AbcSize
  def self.command_call_top_words(args)
    top_words(args[0].gsub("#{ARTIST_KEY}=", '')) if args.size == 1 && args[0].include?(ARTIST_KEY)
    top_words(args[0].gsub("#{RANGE_KEY}=", ''), args[1].gsub("#{ARTIST_KEY}=", '') + args[2..args.size].join(' '))\
    if args.size >= 2 && args[0].include?(RANGE_KEY)
  end
  # rubocop:enable Metrics/AbcSize

  def self.send_command(args)
    help if args.size == 1 && args.include?(HELP_KEY)
    command_call_top_words(args)
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
