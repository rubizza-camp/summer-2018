module DAO

  class BattleDAO
    def initialize
      indata_from_file = HelperDAO.new.read_from_file('../data/Alias.config')
      @alias = []
      indata_from_file.each_with_index do |ally, i|
        @alias[i] = ally.gsub(/ {2,}\n/, '')
      end
    end

    def get_artist_list_from_battles(path_to_folder)
      artists = []
      Dir[path_to_folder].each do |file|
        buffer = HelperDAO.new.read_from_file(file)
        file = file.slice('../data/battle_text/'.length + 1, file.length)
        mc = file.split('против')[0]
        artist_num = find_artist(artists, mc)
        if artist_num == 0
          artist = Artist.new(mc)
        else
          artist = artists[artist_num]
        end
        parsed_text = ''
        buffer.each {|line| parsed_text += line if !line.include?('раунд') || !line.include?('Раунд')}
        artist.add_battle(exclude_words(parsed_text))
        artists << artist
      end
      artists
    end

    def find_artist(artist_list, name)
      artist_result_num = 0
      standard_name = name
      @alias.each do |ally_name|
        if ally_name.split(';').include?(name)
          standard_name = ally_name[0]
          break
        end
      end
      artist_list.each_with_index{|artist, i| artist_result_num = i if artist.name == standard_name}
      artist_result_num
    end

    def exclude_words(indata)
      excluded_words = HelperDAO.new.read_from_file('../template/ExcludedWords.txt')
      indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
      indata = indata.split(' ').select { |each_word| each_word.length >= 4}
      indata
    end
  end
end
