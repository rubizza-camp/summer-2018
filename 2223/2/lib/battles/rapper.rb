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
      (total_bad_words / total_battles.to_f).round
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
       "#{total_battles} #{Russian.p(total_battles, 'батл', 'батла', 'батлов')}",
       "#{total_bad_words} нецензурных #{syntax_word(total_bad_words)}",
       "#{bad_words_for_battle} #{syntax_word(bad_words_for_battle)} на батл",
       "#{words_for_round} #{syntax_word(words_for_round)} в раунде"]
    end

    def rhymes
      speeches.inject({}) do |all_rhymes, speech|
        all_rhymes.merge(speech.rhymes)
      end
    end

    private

    def syntax_word(number)
      Russian.p(number, 'слово', 'слова', 'слов')
    end

    def total_battles
      speeches.size
    end

    def total_words
      speeches.flat_map(&:words).size
    end

    def total_bad_words
      speeches.sum(&:total_bad_words)
    end

    def total_rounds
      speeches.sum(&:rounds)
    end

    def words_for_round
      (total_words / total_rounds.to_f).round
    end

    def consider_word(word)
      Morphy.new.query(word).first.normal_form
    rescue NoMethodError
      word
    end
  end
end
