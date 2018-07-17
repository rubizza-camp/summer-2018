require_relative './parser.rb'
require 'russian_obscenity'
require 'terminal-table'
require_relative 'pluralize.rb'
RussianObscenity.dictionary = [:default, 'dictionary.yml']
# Form the table of top battlers with the biggest count of foul words
class TopBattlers
  attr_reader :rapers, :result

  def initialize
    @rapers = Parser.new.read_files
    @result = []
  end

  def bad_words_searching(text)
    count = 0
    dictionary = RussianObscenity.find(text)
    dictionary.each do |bad|
      count += text.split(' ').count(bad)
    end
    count
  end

  def rounds_in_battle(text)
    count = text.scan(/(раунд)\s?\d/i).size
    return 1 if count < 1
    count
  end

  def sort_list
    @rapers.sort_by do |_key, value|
      bad_words_searching(value.join(' '))
    end.reverse
  end

  def show(arr)
    table = Terminal::Table.new(rows: arr)
    puts table
  end

  # def create_row(*arg)
  #     word_setting = [%w[слово слова слов], %w[нецензурное нецензурных нецензурных], %w[батл батла батлов]]
  #     row = [key.to_s,
  #            "#{battles} #{pluralize(battles, word_setting.last)}",
  #            "#{foul_words} #{pluralize(foul_words, word_setting[1])} #{pluralize(foul_words, word_setting.first)}",
  #            "#{bad_words_per_battle.round(2)} на батл",
  #            "#{words_in_round} #{pluralize(words_in_round, word_setting.first)} в раунде"]
  #     @result << row
  # end

  def result_table(count = 20)
    sort_list.to_h.first(count).each do |key, value|
      text = value.join(' ')
      battles = value.size
      words_in_round = text.split(' ').size / (battles * 3)
      foul_words = bad_words_searching(text)
      bad_words_per_battle = foul_words / battles.to_f

      word_setting = [%w[слово слова слов], %w[нецензурное нецензурных нецензурных], %w[батл батла батлов]]
      row = [key.to_s,
             "#{battles} #{pluralize(battles, word_setting.last)}",
             "#{foul_words} #{pluralize(foul_words, word_setting[1])} #{pluralize(foul_words, word_setting.first)}",
             "#{bad_words_per_battle.round(2)} на батл",
             "#{words_in_round} #{pluralize(words_in_round, word_setting.first)} в раунде"]
      @result << row
    end
    show(result)
  end
end

# inst = TopBattlers.new
# inst.result_table(20)
