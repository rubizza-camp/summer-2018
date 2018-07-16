require 'terminal-table'
require_relative 'parser'

module Battles
  class Statistic
    def self.call(params)
      Statistic.new(params).call
    end

    def initialize(params)
      @params = params.map { |str| str.split('=') }.to_h
      @rappers = Parser.rappers
    end

    def call
      top_bad_words if params['--top-bad-words']
      top_popular_words if params['--name']
      plagiat if params['--plagiat']
    end

    private

    attr_reader :params, :rappers

    def param_value(param)
      param.split('=')
    end

    def top_bad_words(amount = params['--top-bad-words'] || 30)
      top_rappers = rappers.sort_by(&:bad_words_for_battle).reverse.first(amount.to_i)
      puts Terminal::Table.new(rows: top_rappers.map(&:information))
    end

    def top_popular_words(name = params['--name'], amount = params['--top-words'])
      rapper = rapper_by_name(name)
      if rapper
        show_popular_words(rapper, amount)
      else
        error_find_rapper(name)
      end
    end

    def plagiat(name = params['--plagiat'])
      rapper = rapper_by_name(name)
      if rapper
        check_plagiat(rapper)
      else
        error_find_rapper(name)
      end
    end

    def error_find_rapper(name)
      puts "Рэпер #{name} не известен мне. Зато мне известны:"
      puts rappers.map(&:name).sort
    end

    def check_plagiat(rapper)
      other_rappers(rapper.name).each do |other_rapper|
        check_rhymes(rapper, other_rapper)
      end
    end

    def check_rhymes(verifiable_rapper, other_rapper)
      verifiable_rapper_rhymes = verifiable_rapper.rhymes
      other_rapper_rhymes = other_rapper.rhymes
      (verifiable_rapper_rhymes.keys & other_rapper_rhymes.keys).each do |rhyme|
        show_rhyme(verifiable_rapper.name, verifiable_rapper_rhymes[rhyme])
        show_rhyme(other_rapper.name, other_rapper_rhymes[rhyme])
      end
    end

    def rapper_by_name(name)
      rappers.find { |author| author.name == name }
    end

    def other_rappers(name)
      rappers.delete_if { |author| author.name == name }
    end

    def show_rhyme(name, rhyme)
      puts name
      puts rhyme
      puts '-' * 30
    end

    def show_popular_words(rapper, amount)
      rapper.popular_words.sort_by(&:last).reverse.first(amount.to_i).to_h.each do |word, count|
        puts "#{word.capitalize} - #{count} раз"
      end
    end
  end
end
