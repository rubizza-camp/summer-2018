module Rap
  # :reek:FeatureEnvy
  class Rhymes
    attr_reader :rhymes, :battle

    def initialize(file_name)
      @rhymes = []
      @battle = file_name
    end

    # :reek:TooManyStatements
    def make_rhymes_from_words(words)
      words.each_index do |ind|
        one_part_of_rhyme = words[ind]
        next_inds = ind + 1
        while next_inds < words.size && next_inds <= ind + 4
          rhymes << one_part_of_rhyme + ' - ' + words[next_inds]
          next_inds += 1
        end
      end
      rhymes.uniq!
    end

    def all_rhymes_pairs_excluding_self(rhymes_objects)
      rhymes_pairs_list = []
      rhymes_objects.each do |rhyme_object|
        rhymes_pairs_list << rhyme_object.rhymes if rhyme_object != self
      end
      rhymes_pairs_list.flatten
    end
  end
end
