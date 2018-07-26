module Versus
  # Factory, that explores directory with text files and creates Battle objects
  # can optional take parametres name to explore only this rapper's battles
  class DirectoryExplorer
    def initialize(name = nil, path = nil)
      @paths = path ? Dir[path + '/*'] : Dir[__dir__ + '/texts/*'] # Array of paths to each file
      @name = name
    end

    def make_rappers_hash
      rappers_hash = {}
      @paths.each do |path|
        name_in_file = get_name_in_file(path)
        rappers_hash = explore_file(name_in_file, path, rappers_hash) if !@name || name_in_file == @name
      end
      rappers_hash
    end

    def make_names_list
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
      battle = FileExplorer.new(file).explore
      add_battle_to_rapper(name, battle, rappers_hash)
    end

    def add_battle_to_rapper(name, battle, rappers_hash)
      rappers_hash[name.to_sym] ||= Rapper.new(name)
      rappers_hash[name.to_sym].add_battle(battle)
      rappers_hash
    end
  end
end
