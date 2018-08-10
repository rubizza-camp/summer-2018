# This class smells of :reek:MissingSafeMethod
class CurseWordsCommand < BaseCommand
  def execute
    RapperRegistry.instance.rappers
    calculate_bad_words
    calculate_bad_words_per_battle
    calculate_bad_words_per_round
    calculate_all_words_per_battle
  end

  def presenter
    BadWordsPresenter.new(rappers)
  end

  def calculate_battles; end

  def calculate_battle_words; end

  def calculate_bad_words_per_round; end

  def calculate_all_words_per_round; end
end

# Class present bad_words stats
# This method smells of :reek:Attribute
class BadWordsPresenter < TablePresenter
  attr_accessor :rappers

  def initialize(rappers)
    @rappers = rappers
  end

  def header
    %w(rapper battles_per bad_words_per_round all_words_per_round)
  end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:FeatureEnvy
  def rows
    rappers.map do |author|
      [
        author.name,
        "#{author.battles_count} #{RussianDeclensions.battles_count_for_raper(author.battles_count)}",
        "#{author.bad_words} #{RussianDeclensions.bad_words(author.bad_words)}",
        "#{author.bad_words_per_battle} #{RussianDeclensions.word(author.bad_words_per_battle)} на баттл",
        "#{author.words_per_round} #{RussianDeclensions.word(author.words_per_round)} в раунде"
      ]
    end
  end
end

# Class present table
class TablePresenter
  def table
    Terminal::Table.new rows: rows
  end
end
