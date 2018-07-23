require 'memoist'
require_relative 'correct_strings'
require_relative 'battle'

module Rap
  class Rapper
    extend Memoist
    attr_reader :name, :battles

    def initialize(rapper_name)
      @name = rapper_name
      @battles = []
    end

    def push_battle(battle)
      @battles << battle
      self
    end

    def choose_better_name(other_name)
      @name = name.length > other_name.length ? other_name : name
    end

    def fill_battles
      battles.each(&:fill_rounds)
      self
    end

    def battles_amount
      battles.size
    end

    def all_words
      battles.inject([]) { |all_words, battle| all_words << battle.all_words }
    end

    def bad_words
      battles.inject([]) { |bad_words, battle| bad_words << battle.bad_words }
    end

    def all_words_amount
      all_words.flatten.size
    end

    def bad_words_amount
      bad_words.flatten.size
    end

    def rounds_amount
      battles.inject(0) { |sum, battle| sum + battle.rounds.size }
    end

    def average_bad_for_battle
      bad_words_amount.to_f / battles_amount
    end

    def average_words_for_rounds
      all_words_amount.to_f / rounds_amount
    end

    def to_s
      str = name.ljust(23) + '| ' + CorrectStrings.full_string(battles_amount, bad_words_amount, average_bad_for_battle)
      str += CorrectStrings.average_rounds(average_words_for_rounds)
      str
    end

    memoize :all_words, :bad_words, :bad_words_amount, :average_bad_for_battle
  end
end
