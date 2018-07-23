# :reek:UtilityFunction
# Find methods
module FindModule
  PATH_FOLDER = 'Rapbattle'.freeze
  def find_participants_titles(participant)
    Dir.chdir(PATH_FOLDER) do
      Dir.glob("*#{participant}*").each_with_object([]) do |title, array_files|
        array_files << title if title.split('против')
                                     .first.include?(participant)
      end
    end
  end

  def find_participants
    Dir.glob("#{PATH_FOLDER}/*против*").each_with_object([]) do |title, names|
      names << title.split("#{PATH_FOLDER}/ ").last
                    .split('против').first.strip
    end
  end
end
