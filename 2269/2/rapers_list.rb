# :reek:FeatureEnvy
# :reek:TooManyStatements
def get_rapers(destination)
  hash = {}
  files = Dir.entries(destination).reject { |file| File.directory? file }
  files.each do |file|
    raper_name = file.split(' против')
    raper_name = raper_name[0].split(/\s[Vv][Ss]/)[0].split(' aka')[0].lstrip

    hash[raper_name] = Raper.new raper_name unless hash[raper_name]
    setup_raper hash, raper_name, file
  end
  hash
end

# :reek:UtilityFunction
def setup_raper(hash, raper_name, file)
  hash[raper_name].add_battle file
end
