module Rap
  class RapperKeyFinder
    def self.find_rapper_key(rappers_hash, rapper_name)
      rapper_name = rapper_name.downcase
      rappers_hash.keys.find do |key|
        key = key.downcase
        compare_key_and_name(key, rapper_name)
      end
    end

    def self.compare_key_and_name(key, name)
      name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
    end
  end
end
