# Class find all participant names
class ParticipantsNameLoader
  PATH_FOLDER = 'Rapbattle'.freeze
  attr_reader :participant_names
  def initialize
    find_names
  end

  def find_names
    @participant_names =
      Dir.glob("#{PATH_FOLDER}/*против*").each_with_object([]) do |title, names|
        names << title.split("#{PATH_FOLDER}/ ").last
                      .split('против').first.strip
      end
  end
end
