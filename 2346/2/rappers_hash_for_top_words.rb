require_relative 'base_rapper_hash'
require_relative 'top_words_counter'

module Rap
  class RappersHashForTopWords
    include BaseRappersHash

    def initialize
      @rappers_hash = {}
      fill_rapper_hash
    end

    def result_for_second(name, quantity)
      possible_key = RapperKeyFinder.find_rapper_key(rappers_hash, name)
      if possible_key
        counter = TopWordsCounter.new
        counter.count(rappers_hash[possible_key], quantity)
      else
        unknown_rapper(name)
      end
    end

    def unknown_rapper(name)
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      rappers_hash.keys.each { |key| puts key }
    end
  end
end
