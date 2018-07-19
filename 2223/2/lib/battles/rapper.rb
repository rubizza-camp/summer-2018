require 'morphy'
require 'russian'

module Battles
  class Rapper
    attr_reader :name, :speeches

    def initialize(name, speeches)
      @name = name
      @speeches = speeches.map { |speech| Speech.new(speech) }
    end

    def bad_words_for_battle
      (amount_bad_words / amount_battles.to_f).round
    end

    def popular_words
      words = speeches.flat_map(&:key_words)
      select_popular_words(words)
    end

    def select_popular_words(words)
      words.each_with_object(Hash.new(0)) do |word, popular_words|
        popular_words[consider_word(word)] += 1
        popular_words
      end.sort_by(&:last).to_h
    end

    def information
      [name,
       "#{amount_battles} #{Russian.p(amount_battles, 'батл', 'батла', 'батлов')}",
       "#{amount_bad_words} нецензурных #{syntax_word(amount_bad_words)}",
       "#{bad_words_for_battle} #{syntax_word(bad_words_for_battle)} на батл",
       "#{words_for_raund} #{syntax_word(words_for_raund)} в раунде"]
    end

    def rhymes
      speeches.inject({}) do |all_rhymes, speech|
        all_rhymes.merge(speech.rhymes)
      end
    end

    private

    def syntax_word(amount)
      Russian.p(amount, 'слово', 'слова', 'слов')
    end

    def amount_battles
      speeches.size
    end

    def amount_words
      speeches.flat_map(&:words).size
    end

    def amount_bad_words
      speeches.map(&:amount_bad_words).sum
    end

    def amount_raunds
      speeches.map(&:raunds).sum
    end

    def words_for_raund
      (amount_words / amount_raunds.to_f).round
    end

    def consider_word(word)
      Morphy.new.query(word).first.normal_form
    rescue NoMethodError
      word
    end
  end
end
