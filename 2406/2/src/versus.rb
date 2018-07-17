Dir['Models/*.rb'].each { |file| load(file) }
Dir['DAO/*.rb'].each { |file| require_relative file }
require 'terminal-table'

BAD_WORDS_KEY = '--top-bad-words'.freeze
ARTIST_NAME_KEY = '--name'.freeze
RANGE_KEY = '--top-words'.freeze
PLAG_KEY = '--plagiat'.freeze
HELP_KEY = '--help'.freeze

DEFAULT_RANGE = 30

def create_table(base_of_artists, range)
  Terminal::Table.new do |row|
    base_of_artists[0..range].each do |artist|
      row << [to_s(artist.name),
              "#{artist.get_battle_capacity} батлов",
              "#{artist.get_bad_words_capacity} нецензурных слов",
              "#{artist.get_words_in_battle_average} слов на баттл",
              "#{artist.get_words_in_round_average} слов в раунде"]
    end
  end
end

def bad_words(*args)
  range = args[0].nil? ? DEFAULT_RANGE : Integer(args[0])
  puts('Incorrect range taken.') unless (1..100).cover?(range)
  base_of_artists = DAO::BattleDAO.new.get_artist_list_from_battles('../data/battle_text/*')
  base_of_artists = base_of_artists.sort_by(&:get_battle_capacity).reverse.uniq
  puts create_table(base_of_artists, range)
end

def top_words(*_args)
  puts 'Under construction'
  # artist = args[1]
  # range = args[0]
  # artist_exist = false
  # DAO::Artist_DAO._artists().each {|artist_base|
  #  if artist_base.name == artist
  #    artist_exist = true;
  #    break;
  #   end
  # }
  # if (artist == '') || (artist_exist)
  #  puts('No artist with that name in base.')
  #  exit(1)
  # end
  puts('Incorrect range taken.') unless (1..100).cover?(range)
  # TODO: Second task with top words for artist
end

def plagiat
  puts('Under construction')
  # TODO: Third task with plagiat
end

def help
  puts HelperDAO.new.read_from_file('../template/help.txt')
end

def send_command(args)
  get_help if args.size == 1 && args.include?(HELP_KEY)
  bad_words(args[0].gsub("#{BAD_WORDS_KEY}=", '')) if args.size == 1 && args[0].cover?(BAD_WORDS_KEY)
end

def check_arguments(args)
  valid_keys = [BAD_WORDS_KEY, ARTIST_NAME_KEY, RANGE_KEY, PLAG_KEY, HELP_KEY]
  include_in_valid_keys = false
  args.each { |arg| include_in_valid_keys = valid_keys.any? { |valid_key| arg.cover?(valid_key) } }
  include_in_valid_keys
end

def main
  args = ARGV
  puts('No valid keys taken. Using key "--help" to get help.') if !check_arguments(args) || !(1..2).cover?(ARGV.size)
  send_command(args)
end

main
