module Rap
  class RhymesPairsListWithExcluded
    attr_reader :excluded_object
    def initialize(objects_array, excluded_object)
      @objects_array = objects_array
      @excluded_object = excluded_object
      @list = []
    end

    def list_without_excluded
      @objects_array.each do |rhyme_object|
        @list << rhyme_object.rhymes if rhyme_object != @excluded_object
      end
      @list.flatten
    end
  end
end
