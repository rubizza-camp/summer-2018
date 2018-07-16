module DAO

  class BattleDAO
    def initialize
      @alias = HelperDAO.new.read_from_file('../data/Alias.config')
    end

    def get_battles_list(path_to_folder)
      result = []
      round_list = []
      artists = []
      @alias.each {|alias_name| artists << Artist.new(alias_name.split(';')[0])}
      Dir[path_to_folder].each do |file|
        buffer = HelperDAO.new.read_from_file(file)
        file = file.slice('../data/battle_text/'.length + 1, file.length)
        mc = file.split('против')[0]
        parsed_text = ''
        buffer.each {|line| parsed_text += line if !line.include?('раунд') || !line.include?('Раунд')}
        #Филтровать раунд исполнителя от ненужных слов
        artists[find_artist_from_list(mc, artists)].add_battle(Battle.new(artists[find_artist_from_list(mc, artists)], parsed_text))
      end
    end

    def find_artist_from_list(mc, artists)
      index = 0
      artists.each do |artist|
        @alias.each_with_index {|name_list, i| index = i if name_list.include?(mc)}
        artist.name
      end
      index
    end
  end
end
