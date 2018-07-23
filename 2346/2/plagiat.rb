require_relative 'rhymes'

module Rap
  class Plagiat
    def self.result(rhymes_objects)
      rhymes_objects.each do |rhyme_current|
        rhymes_pairs_list = RhymesPairsMethods.new(rhyme_current).all_rhymes_pairs_without_excluded(rhymes_objects)
        rhymes_plagiat = rhyme_current.rhymes & rhymes_pairs_list
        print_plagiat(rhyme_current.battle, rhymes_plagiat)
      end
    end

    def self.print_plagiat(current, res)
      puts current
      puts !res.empty? ? res : 'НЕТ ПЛАГИАТА'
      puts
    end
  end
end
