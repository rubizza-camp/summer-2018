require_relative 'Helper.rb'
require_relative 'HelperDAO.rb'

module CommandProccessor
  BAD_WORDS_KEY = '--top-bad-words'.freeze
  HELP_KEY = '--help'.freeze
  HELP_TEXTFILE = '../template/help.txt'.freeze

  include Helper
  include HelperDAO

  def bad_words_command(*args)
    range = Helper.range_correction(args[0])
    raise ArgumentError, 'Number is out of range.' unless (1..100).cover?(range)
    base_of_artists = HelperDAO.load_artist_list_from_file.sort_by(&:bad_words_capacity).reverse.uniq
    puts create_table(base_of_artists, range)
  end

  def help_command
    puts HelperDAO.read_from_file(HELP_TEXTFILE)
  end

  def self.check_arguments(args)
    return false unless [BAD_WORDS_KEY, HELP_KEY].any? { |valid_key| args[0].include?(valid_key) }
    true
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

  def create_table(base_of_artists, range)
    Terminal::Table.new do |row|
      create_rows(row, base_of_artists, range)
    end
  end

  def self.send_command(args)
    help_command if args.size == 1 && args.include?(HELP_KEY)
    bad_words_command(args[0].gsub("#{BAD_WORDS_KEY}=", '')) if args.size == 1 && args[0].include?(BAD_WORDS_KEY)
  end
end
