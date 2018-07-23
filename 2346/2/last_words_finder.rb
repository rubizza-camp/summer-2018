module Rap
  class LastWordsFinder
    def self.find_in_file(file)
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