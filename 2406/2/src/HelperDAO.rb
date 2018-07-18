class HelperDAO
  FILE_NAME_LENGTH = 21

  # Function doesn't work without all that statements
  # This method smells of :reek:TooManyStatements
  def self.read_from_file(path)
    file = File.new(path, 'r')
    buffer = []
    counter = 0
    while (line = file.gets)
      buffer << '           ' + line
      counter += 1
    end
    file.close
    buffer
  end

  def self.find_artist(artist_list, name)
    artist_result_num = 0
    name = find_artist_name(name)
    artist_list.each_with_index { |artist, index| artist_result_num = index if artist.name == name }
    artist_result_num
  end

  def self.take_artist(artists, artist_num, artist_name)
    artist_num.zero? ? Artist.new(artist_name) : artists[artist_num]
  end

  def self.take_artist_name(file)
    file = file.slice(FILE_NAME_LENGTH, read_from_file(file).length)
    file.split('против')[0]
  end

  def self.find_artist_name(name)
    Helper.load_alias_list.each do |ally_name|
      if ally_name.split(';').include?(name)
        name = ally_name[0]
        break
      end
    end
    name
  end

  # Function doesn't work without all that statements, because work with file
  # This method smells of :reek:TooManyStatements
  def self.artist_list(path_to_folder)
    artists = []
    Dir[path_to_folder].each do |file|
      artists << take_artist(artists, find_artist(artists, take_artist_name(file)), take_artist_name(file))
      artist = artists[find_artist(artists, take_artist_name(file))]
      artist.add_battle(Helper.exclude_words(Helper.read_from_buffer(read_from_file(file))))
    end
    artists
  end
end
