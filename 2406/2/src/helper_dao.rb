require_relative 'parser.rb'

module HelperDAO
  BATTLES = '../data/battle_text/*'.freeze

  include Parser
  # It's minimal statements for that method. Removing a tmp_artist will result in loss of performance
  # This method smells of :reek:TooManyStatements
  def self.load_artist_list_from_file
    artists = []
    Dir[BATTLES].each do |file|
      tmp_artist = Parser.take_artist_instance(artists, file)
      artists << tmp_artist if tmp_artist.battle_list.empty?
      tmp_artist.add_battle(Helper.exclude_garbage(Helper.delete_round_name_lines(File.readlines(file))))
    end
    artists
  end
end
