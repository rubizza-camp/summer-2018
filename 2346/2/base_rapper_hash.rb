module Rap
  module BaseRappersHash
    attr_reader :rappers_hash

    def fill_rapper_hash
      all_paths = Rap.find_files
      all_paths.each { |path| update_hash(path.to_s) }
    end

    def find_rapper_key(rapper_name)
      rapper_name = rapper_name.downcase
      rappers_hash.keys.find do |key|
        key = key.downcase
        compare_key_and_name(key, rapper_name)
      end
    end

    def add_battle_to_existing_rapper(key, name, battle)
      rappers_hash[key].push_battle(battle).choose_better_name(name)
    end

    def update_hash(path)
      rapper_battle = Battle.new(path)
      rapper_name = rapper_battle.participant_name
      possible_key = find_rapper_key(rapper_name)
      if possible_key
        add_battle_to_existing_rapper(possible_key, rapper_name, rapper_battle)
      else
        @rappers_hash[rapper_name] = Rapper.new(rapper_name).push_battle(rapper_battle)
      end
    end

    private

    def compare_key_and_name(key, name)
      name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
    end
  end
end
