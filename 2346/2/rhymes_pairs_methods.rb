module Rap
  class RhymesPairsMethods
    attr_reader :excluded_object
    def initialize(excluded_object)
      @excluded_object = excluded_object
    end

    def all_rhymes_pairs_without_excluded(rhymes_objects)
      rhymes_pairs_list = []
      rhymes_objects.each do |rhyme_object|
        rhymes_pairs_list << rhyme_object.rhymes if rhyme_object != excluded_object
      end
      rhymes_pairs_list.flatten
    end
  end
end
