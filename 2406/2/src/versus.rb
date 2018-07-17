#!/usr/bin/ruby
Dir['Models/*.rb'].each {|file| load(file) }
Dir['DAO/*.rb'].each {|file| require_relative file }

BAD_WORDS_KEY = '--top-bad-words'
ARTIST_NAME_KEY = '--name'
RANGE_KEY = '--top-words'
PLAG_KEY = '--plagiat'
HELP_KEY = '--help'

DEFAULT_RANGE = 30

def bad_words(range)
  if !(1..100).cover?(range)
    puts('Incorrect range taken.')
    exit(1)
  end
  base_of_artists = DAO::BattleDAO.new.get_artist_list_from_battles('../data/battle_text/*')
  base_of_artists.each {|artist| puts "#{artist.name}) #{artist.get_bad_words}"}
  #print base_of_artists
end

def top_words(*args)
  puts ('Under construction')
  #artist = args[1]
  #range = args[0]
  #artist_exist = false
  #DAO::Artist_DAO.get_artists().each {|artist_base|
  #  if artist_base.name == artist
  #    artist_exist = true;
  #    break;
  #   end
  # }
  #if (artist == '') || (artist_exist)
  #  puts('No artist with that name in base.')
  #  exit(1)
  #end
  if !(1..100).cover?(range)
    puts('Incorrect range taken.')
    exit(1)
  end
  #TODO: Second task with top words for artist
end

def plagiat()
  puts('Under construction')
  #TODO: Third task with plagiat
end

def get_help
  puts HelperDAO.new.read_from_file('../template/help.txt')
end

def main
  valid_keys = [BAD_WORDS_KEY, ARTIST_NAME_KEY, RANGE_KEY, PLAG_KEY, HELP_KEY]
  include_in_valid_keys = false
  ARGV.each { |arg| include_in_valid_keys = valid_keys.any?{ |valid_key| arg.include?(valid_key) }}
  puts('No valid keys taken. Using key "--help" to get help.') if !include_in_valid_keys || !(1..2).include?(ARGV.size)
  get_help() if ARGV.size == 1 && ARGV.include?(HELP_KEY)
  bad_words(Integer(String.new((ARGV[0]).slice(BAD_WORDS_KEY.length + 1, ARGV[0].length)))) if ARGV.size == 1 && ARGV[0].include?(BAD_WORDS_KEY)
  top_words(String.new(ARGV[0]).slice(ARTIST_NAME_KEY.length + 1, ARGV[0].length)) if ARGV.size == 1 && ARGV[0].include?(ARTIST_NAME_KEY)
  top_words(String.new(ARGV[0]).slice(RANGE_KEY.length + 1, ARGV[0].length), String.new(ARGV[1]).slice(ARTIST_NAME_KEY.length + 1, ARGV[1].length)) if ARGV.size == 2 && ARGV[1].include?(ARTIST_NAME_KEY) && ARGV[0].include?(RANGE_KEY)
  plagiat() if ARGV.size == 1 && ARGV.include?(PLAG_KEY)
end

main
