# class detects original participant name
class ParticipantNameLoader
  ALIASES = YAML.load_file('alias.yml')

  def initialize(filename)
    @filename = filename
  end

  # :reek:NilCheck
  def participant_name
    name = @filename.split(/ против | vs /i).first.split('/').last.strip
    ALIASES.find do |_, aliases|
      aliases.include?(name)
    end&.first || name
  end
end
