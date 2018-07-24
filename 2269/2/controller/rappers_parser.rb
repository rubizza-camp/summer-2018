# This module creates a Rappers and makes it initiating
module RappersParser
  def get_rappers_list(destination)
    hash = {}
    Dir.entries(destination).reject { |file| File.directory? file }.each do |file|
      rapper_name = file.split(' против')
      rapper_name = rapper_name[0].split(/\s[Vv][Ss]/)[0].split(' aka')[0].lstrip

      hash[rapper_name] = Rapper.new rapper_name unless hash[rapper_name]
      setup_rapper_info hash, file, rapper_name
    end
    hash
  end

  def setup_rapper_info(hash, file, rapper_name)
    hash[rapper_name].add_battle
    hash[rapper_name].words_info_during_battles.file_source_info file
  end
end
