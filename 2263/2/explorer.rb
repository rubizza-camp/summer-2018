# Factory class that explore directory with battle texts, creates Battle and Rapper objects,
# and initialize Rapper objects with the appropriate Battle objects. Optional can take single name
# on purpose to not create extra objects
class Explorer
  attr_reader :name, :paths

  def initialize(name = nil, path = nil)
    @paths = path ? Dir[path + '/*'] : Dir[__dir__ + '/texts/*'] # Array of paths to each file
    @name = name
  end

  def explore
    rappers_hash = {}
    @paths.each do |path|
      name_in_file = get_name_in_file(path)
      rappers_hash = explore_file(name_in_file, path, rappers_hash) if !@name || name_in_file == @name
    end
    rappers_hash
  end

  def names_list
    names_list = []
    @paths.each do |path|
      name = get_name_in_file(path)
      names_list << name unless names_list.include?(name)
    end
    names_list
  end

  private

  def get_name_in_file(path)
    name_in_file = path.match(%r{(?<=/texts/\s).*?((?=\s+против\s+)|(?=\s+VS\s+)|(?=\s+vs\s+))}).to_s
    name_in_file == '' ? raise(ExplorerFileNameError, path) : name_in_file
  end

  def explore_file(name, path, rappers_hash)
    file = File.open(path)
    battle = Battle.new(file)
    add_battle_to_rapper(name, rappers_hash, battle)
  end

  def add_battle_to_rapper(name, rappers_hash, battle)
    rappers_hash[name.to_sym] ||= Rapper.new(name)
    rappers_hash[name.to_sym].add_battle(battle)
    rappers_hash
  end
end

# Exception, that is raised when file name doesn't match the name pattern
class ExplorerFileNameError < StandardError
  def initialize(path, message = nil)
    @path = path
    @message = message ? default_message : message
  end

  private

  def default_message
    "Error. Name of file #{@path} doesn't match the text name pattern"
  end
end
