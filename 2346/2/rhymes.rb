require_relative 'last_words_finder'
require_relative 'rhymes_pairs_list_with_excluded'

module Rap
  class Rhymes
    attr_reader :rhymes, :battle

    def initialize(file_name)
      @rhymes = []
      @battle = file_name
      @words = []
    end

    def search_rhymes
      @words = LastWordsFinder.find_in_file(battle)
      make_rhymes_pairs_from_words
      @rhymes.uniq!
      self
    end

    def make_rhymes_pairs_from_words
      @words.each_index do |ind|
        one_part_of_rhyme = @words[ind]
        next_ind = ind + 1
        while next_ind < @words.size && next_ind <= ind + 4
          @rhymes << one_part_of_rhyme + ' - ' + @words[next_ind]
          next_ind += 1
        end
      end
    end
  end
end
