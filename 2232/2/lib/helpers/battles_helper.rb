require_relative 'directory_helper'
require_relative '../battler'
require_relative '../top_word'
require_relative 'top_word_params'

module BattlesHelper
  include DirectoryHelper
  include TopWordParams

  def top_words(name)
    text_bat = text_battler(name)
    if text_bat.empty?
      puts "Рэпер #{name} мне не известен. Выберите из списка:"
      puts battlers
      []
    else
      initialize_top_words(text_bat.join(' '))
    end
  end

  def top_battlers
    @top_battlers ||= battlers.sort_by { |el| el.params[:curses_per_battle] }.reverse
  end

  private

  def initialize_battler(name)
    Battler.new(name, text_battler(name))
  end

  def battlers
    battler = DirectoryHelper.take_all_battles.map { |battle| name_battler(battle) }.uniq
    battler.each_with_object([]) { |battle, battles| battles << initialize_battler(battle) }
  end
end
