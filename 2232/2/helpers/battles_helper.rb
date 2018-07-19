require_relative 'directory_helper'
require_relative '../battler'
require_relative '../top_word'

module BattlesHelper
  include DirectoryHelper

  PREPOSITIONS = 'prepositions'.freeze

  def top_words(name_bat)
    text_bat = text_battler(name_bat)
    if text_bat.empty?
      puts "Рэпер #{name_bat} мне не известен. Выберите из списка:"
      puts battlers
      []
    else
      words_battler(text_bat.join(' '))
    end
  end

  def top_battlers
    battler = battlers.each_with_object([]) { |el, arr| arr << initialize_battler(el) }
    battler.sort_by { |el| el.params[:curse_bat] }.reverse
  end

  def tabular_output(rows_arr, headings)
    puts Terminal::Table.new(headings: headings, rows: rows_arr.map(&:show))
  end

  private

  def initialize_battler(name_bat)
    Battler.new(name_bat, text_battler(name_bat))
  end

  def battlers
    DirectoryHelper.take_all_battles.map { |el| name_battler(el) }.uniq
  end

  def name_battler(title)
    title.split('против')[0].strip
  end

  def words_battler(text_bat)
    prepositions = File.read(PREPOSITIONS).split(',')
    words = text_bat.split.uniq.each_with_object([]) do |el, arr|
      arr << TopWord.new(el, text_bat.split.count(el)) unless prepositions.include?(el)
    end
    words.sort_by(&:count).reverse
  end

  def text_battler(name_bat)
    DirectoryHelper.take_all_battles.each_with_object([]) do |el, arr|
      arr << DirectoryHelper.take_text_battler(el) if name_battler(el).eql?(name_bat)
    end
  end
end
