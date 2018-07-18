Dir['Models/*.rb'].each { |file| load(file) }

BAD_WORDS_KEY = '--top-bad-words'.freeze
ARTIST_KEY = '--name'.freeze
RANGE_KEY = '--top-words'.freeze
PLAG_KEY = '--plagiat'.freeze
HELP_KEY = '--help'.freeze

DEFAULT_RANGE = 30

require_relative 'HelperDAO.rb'
require_relative 'Helper.rb'

def bad_words(*args)
  range = args[0] ? DEFAULT_RANGE : Integer(args[0])
  raise ArgumentError, 'Number is out of range.' unless (1..100).cover?(range)
  base_of_artists = HelperDAO.artist_list.sort_by(&:bad_words_capacity).reverse.uniq
  puts Helper.create_table(base_of_artists, range)
end

def check_range(range)
  Integer(range)
rescue ArgumentError
  DEFAULT_RANGE
end

def top_words(*args)
  raise ArgumentError, 'Number is out of range.' unless (1..100).cover?(check_range(args[0]))
  raise ArgumentError, 'No artist with that name in base.' unless Helper.artist_exist(args)
  raise NotImplementedError
  # TODO: Second task with top words for artist
end

def plagiat
  raise NotImplementedError
  # TODO: Third task with plagiat
end

def help
  puts HelperDAO.read_from_file('../template/help.txt')
end

def main
  raise ArgumentError, 'No valid keys. Using key "--help" to help.' unless Helper.check_arguments(ARGV)
  Helper.send_command(ARGV)
rescue ArgumentError => error
  puts("Incorrect data. #{error.message}")
rescue NotImplementedError
  puts('That functional is not realize yet.')
end

main
