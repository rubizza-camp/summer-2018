require_relative 'artist'
require_relative 'constants'
# Service class
class Service
  def initialize
    @state = :parsing
  end

  def battlers
    Dir.glob(PATH_TO_FILES).each_with_object({}) do |file_name, rappers|
      next unless File.file?(file_name)
      battlers_parser(file_name, rappers)
    end
  end

  def battlers_parser(file_name, rappers)
    rapper_name = file_name.split(REGEX_FOR_NAMES).first.split('/').last.strip
    (rappers[rapper_name] ||= Artist.new(rapper_name)).add_battles(file_name)
    @state = :parsed
  end
end
