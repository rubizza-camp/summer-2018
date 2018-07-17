Dir['Models/*.rb'].each { |file| load(file) }
Dir['DAO/*.rb'].each { |file| require_relative file }
require 'Helper.rb'

BAD_WORDS_KEY = '--top-bad-words'.freeze
ARTIST_NAME_KEY = '--name'.freeze
RANGE_KEY = '--top-words'.freeze
PLAG_KEY = '--plagiat'.freeze
HELP_KEY = '--help'.freeze

DEFAULT_RANGE = 30
BATTLES = '../data/battle_text/*'.freeze

def bad_words(*args)
  range = args[0] ? DEFAULT_RANGE : Integer(args[0])
  puts('Incorrect range taken.') unless (1..100).cover?(range)
  base_of_artists = DAO::HelperDAO.artist_list_from_battles(BATTLES).sort_by(&:get_battle_capacity).reverse.uniq
  puts Helper.create_table(base_of_artists, range)
end

def top_words(*_args)
  puts 'Under construction'
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

def main
  args = ARGV
  puts('No valid keys. Using key "--help" to help.') if !Helper.check_arguments(args) || !(1..2).cover?(ARGV.size)
  Helper.send_command(args)
end

main
