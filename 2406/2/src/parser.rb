module Parser
  require 'russian_obscenity'

  ALIAS_FILENAME = '../data/Alias.config'.freeze
  FILE_NAME_LENGTH = 21

  def self.find_standard_artist_name(name)
    parse_alias_list.each do |ally_name|
      if ally_name.split(';').include?(name)
        name = ally_name[0]
        break
      end
    end
    name
  end

  def self.parse_name(file)
    file = file.slice(FILE_NAME_LENGTH, File.readlines(file).length)
    file.split('против')[0]
  end

  def self.find_artist_id(artist_list, name)
    artist_list.index { |artist| artist.name == find_standard_artist_name(name) } || 0
  end

  def self.parse_alias_list
    indata_from_file = File.readlines(ALIAS_FILENAME)
    alias_name = []
    indata_from_file.each_with_index do |ally, index|
      alias_name[index] = ally.gsub(/ { 2,}\n/, '')
    end
  end

  def self.bad_words_in_battle(battle)
    battle.count { |word| word.include?('*') || RussianObscenity.obscene?(word) }
  end

  def self.take_artist_instance(artists, file)
    take_artist_instance_private(artists, find_artist_id(artists, parse_name(file)), parse_name(file))
  end

  private

  def take_artist_instance_private(artists, artist_i, artist_name)
    artist_i.zero? ? Artist.new(artist_name) : artists[artist_i]
  end
end
