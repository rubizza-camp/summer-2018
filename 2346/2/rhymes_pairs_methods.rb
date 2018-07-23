module Rap
  class RhymesPairsMethods
    def self.all_rhymes_pairs_excluding_one(rhymes_objects, one_object)
      rhymes_pairs_list = []
      rhymes_objects.each do |rhyme_object|
        rhymes_pairs_list << rhyme_object.rhymes if rhyme_object != one_object
      end
      rhymes_pairs_list.flatten
    end
  end
end