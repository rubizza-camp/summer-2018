require_relative 'parser.rb'

module HelperDAO
  BATTLES = '../data/battle_text/*'.freeze

  include Parser

  def self.load_artist_list_from_file
    artists = []
    Dir[BATTLES].each do |file|
      artists << Parser.take_artist_instance(artists, \
                                             Parser.find_artist_id(artists, Parser.parse_name(file)), \
                                             Parser.parse_name(file))
      artists.last.add_battle(Helper.exclude_garbage(Helper.delete_round_name_lines(File.readlines(file))))
    end
    artists
  end
end
