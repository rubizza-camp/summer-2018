require_relative 'rhymes'

module Rap
  class Plagiat
    def self.result(rhymes_objects)
      result_hash = {}
      rhymes_objects.each do |rhyme_current|
        rhymes_pairs_list = RhymesPairsListWithExcluded.new(rhymes_objects, rhyme_current).list_without_excluded
        fill_result_hash(result_hash, rhyme_current, rhymes_pairs_list)
      end
      result_hash
    end

    def self.fill_result_hash(result_hash, rhyme_current, rhymes_pairs_list)
      rhymes_plagiat = rhyme_current.rhymes & rhymes_pairs_list
      result_hash[rhyme_current.battle] = rhymes_plagiat
    end
  end
end
