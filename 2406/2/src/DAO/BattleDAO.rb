module DAO
  class BattleDAO
    FILE_NAME_LENGTH = 21
    def initialize
      indata_from_file = HelperDAO.new.read_from_file('../data/Alias.config')
      @alias = []
      indata_from_file.each_with_index do |ally, i|
        @alias[i] = ally.gsub(/ { 2,}\n/, '')
      end
    end

    def need_create_new_artist?
      if artist_num.is_zero?
        Artist.new(mc)
      else
        artists[artist_num]
      end
    end

    # I don't understand logic and applicability AbcSize metric in that case
    # rubocop:disable Metrics/AbcSize
    def artist_list(path_to_folder)
      Dir[path_to_folder].each do |file|
        buffer = HelperDAO.new.read_from_file(file)
        file = file.slice(FILE_NAME_LENGTH, file.length)
        mc = file.split('против')[0]

        artists = [] << need_create_new_artist?
        parsed_text = ''
        buffer.each { |line| parsed_text += line if !line.include?('раунд') || !line.include?('Раунд') }
        artists[find_artist(artists, mc)].add_battle(exclude_words(parsed_text))
      end
      artists
    end
    # rubocop:enable Metrics/AbcSize

    def find_artist(artist_list, name)
      artist_result_num = 0
      standard_name = name
      @alias.each do |ally_name|
        if ally_name.split(';').include?(name)
          standard_name = ally_name[0]
          break
        end
      end
      artist_list.each_with_index { |artist, i| artist_result_num = i if artist.name == standard_name }
      artist_result_num
    end

    def exclude_words(indata)
      indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
      indata = indata.split(' ').select { |each_word| each_word.length >= 4 }
      indata
    end
  end
end
