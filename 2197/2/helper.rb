require_relative 'artist'
require_relative 'constants'

# This is a module to decide error in reek
module Helper
  def battlers
    Dir.glob(PATH_TO_FILES).each_with_object({}) do |file_name, rappers|
      next unless File.file?(file_name)
      battlers_parser(file_name, rappers)
    end
  end

  def battlers_parser(file_name, rappers)
    rapper_name = find_artist_by_name(file_name)
    (rappers[rapper_name] ||= Artist.new(rapper_name)).add_battles(file_name)
  end
end
