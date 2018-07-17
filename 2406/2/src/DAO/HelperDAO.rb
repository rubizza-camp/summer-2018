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
    name = Helper.find_artist_name(artist_list, name)
    artist_list.each_with_index { |artist, index| artist_result_num = index if artist.name == name }
    artist_result_num
  end

  def need_create_new_artist?
    if artist_num.is_zero?
      Artist.new(mc)
    else
      artists[artist_num]
    end
  end

  def self.take_artist_name(file)
    file = file.slice(FILE_NAME_LENGTH, read_from_file(file).length)
    file.split('против')[0]
  end

  def self.artist_list(path_to_folder)
    Dir[path_to_folder].each do |file|
      artists << need_create_new_artist?
      artists[find_artist(artists, take_artist_name(file))].add_battle(Helper.exclude_words(read_from_buffer(buffer)))
    end
    artists
  end
end
