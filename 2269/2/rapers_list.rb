def get_rapers_list(destination)
  hash = {}
  Dir.entries(destination).reject { |file| File.directory? file }.each do |file|
    raper_name = file.split(' против')
    raper_name = raper_name[0].split(/\s[Vv][Ss]/)[0].split(' aka')[0].lstrip

    hash[raper_name] = Raper.new raper_name unless hash[raper_name]
    setup_raper_info hash, file, raper_name
  end
  hash
end

def setup_raper_info(hash, file, raper_name)
  hash[raper_name].add_battle
  hash[raper_name].words_info_during_battles.file_source_info file
end
