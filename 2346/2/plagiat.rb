require_relative 'rhymes'

module Rap
  class Plagiat
    def self.search_rhymes(file_name)
      rhymes_in_battle = Rhymes.new(file_name)
      words = last_words_in_lines(file_name)
      rhymes_in_battle.make_rhymes_from_words(words)
      rhymes_in_battle
    end

    def self.print(rhymes_objects)
      rhymes_objects.each do |rhyme_current|
        rhymes_pairs_list = rhyme_current.all_rhymes_pairs_excluding_self(rhymes_objects)
        rhymes_plagiat = rhyme_current.rhymes & rhymes_pairs_list
        print_plagiat(rhyme_current.battle, rhymes_plagiat)
      end
    end

    def self.print_plagiat(current, res)
      puts current
      puts !res.empty? ? res : 'НЕТ ПЛАГИАТА'
      puts
    end

    def self.last_words_in_lines(file)
      words_maybe_rhymes = []
      IO.foreach(file) do |line|
        words_maybe_rhymes << last_words_filter(line)
      end
      words_maybe_rhymes.compact
    end

    def self.last_words_filter(line)
      words = line.downcase.scan(/[ёа-яa-z\*]+/)
      words.delete('quot')
      words.last
    end
  end
end
