require 'pathname'
require_relative 'rapper'
require_relative 'plagiat'
require_relative 'bad_rappers_hash'
require_relative 'rappers_hash_for_top_words'

module Rap
  class Analysis
    def self.first_level(lim)
      rappers_hash = Rap::BadRappersHash.new
      rappers_array = rappers_hash.array_as_result
      if lim <= rappers_array.size
        lim.times { |ind| rappers_array[ind].print }
      else
        rappers_array.each(&:print)
      end
    end

    def self.second_level(name, quantity)
      rappers_hash = RappersHashForTopWords.new
      rappers_hash.result_for_second(name, quantity)
    end

    def self.third_level
      all_paths = Rap.find_files
      rhymes_from_all_battles = []
      all_paths.each do |path|
        rhymes_from_all_battles << Rhymes.new(path).search_rhymes
      end
      Plagiat.result(rhymes_from_all_battles)
    end
  end

  def self.find_files
    Pathname('./rap-battles/').children
  end
end
