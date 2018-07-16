# :reek:DuplicateMethodCall
# :reek:UtilityFunction
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def get_rapers(destination)
  hash = {}
  Dir.entries(destination).each do |file|
    next if ['.', '..'].include?(file)
    raper_name = file.split(' против')
    raper_name = raper_name[0].split(/\s[Vv][Ss]/)
    raper_name = raper_name[0].split(' aka')
    raper_name = raper_name[0].lstrip

    hash[raper_name] = Raper.new raper_name unless hash[raper_name]
    hash[raper_name].add_battle
    hash[raper_name].add_file_name file
  end
  hash
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
