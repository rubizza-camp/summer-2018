require_relative 'base_rapper_hash'

module Rap
  class BadRappersHash
    include BaseRappersHash

    def initialize
      @rappers_hash = {}
      fill_rapper_hash
    end

    def array_as_result
      rappers_hash.values.each(&:fill_battles)
      rappers_array = rappers_hash.values
      rappers_array.sort_by(&:average_bad_for_battle).reverse
    end
  end
end
