# FileReder class to get info about rappers
class FileReader
  def initialize(folder_path)
    @folder_path = folder_path
  end

  def all_files_from_folder_path
    Dir.glob(folder_path + '/*')
  end

  # This method smells of :reek:TooManyStatements
  def read
    all_files_from_folder_path.each do |file_path|
      filename = File.filename(file_path)
      rapper_name = get_rapper_name_from_file_name(filename)
      rapper = registry.find_or_create_by_name(rapper_name)
      battle = read_battle_from_file(file_path)
      rapper.add_battle(battle)
    end
  end

  def get_rapper_name_from_file_name(filename)
    clean_filename = clean_file_name(filename)
    clean_filename.strip.partition(/(\sпротив\s|\svs\s)/i).first
  end

  # This method smells of :reek:UtilityFunction
  def clean_file_name(name)
    name.match(/(.+)\(.+\)/).first
  end

  # This method smells of :reek:UtilityFunction
  def read_battle_from_file(path)
    content = File.open(path).read
    Battle.new(content)
  end

  private

  # This method smells of :reek:UtilityFunction
  def registry
    RapperRegistry.instance
  end
end
