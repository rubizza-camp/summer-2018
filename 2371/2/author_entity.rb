require File.expand_path(File.dirname(__FILE__) + '/constants')
require File.expand_path(File.dirname(__FILE__) + '/battle_entity')

# AuthorEntity responsible for author info
class AuthorEntity
  attr_reader :author_name, :battles_info
  def initialize(author_name, battle_name)
    @author_name = author_name
    @battles = []
    @battles_info = { curse_words: 0, words_percent: 0 }
    add_battle(battle_name)
  end

  def add_battle(battle_file_name)
    return unless File.file?("./texts/#{battle_file_name}")
    @battles << BattleEntity.new(battle_file_name)
    prepare_data
  end

  def bad_words_print
    b_size = @battles.size
    c_size = @battles_info[:curse_words]
    [@author_name,
     "#{b_size} батлов",
     "#{c_size} нецензурных слов",
     "#{format('%.2f', (c_size.to_f / b_size))} слова на баттл",
     "#{@battles_info[:words_percent]} слова в раунде"]
  end

  private

  def prepare_data
    @battles.each do |battle|
      merging(battle)
    end
  end

  def merging(battle)
    @battles_info.merge(battle.data) do |_k, a_value, b_value|
      a_value + b_value
    end
  end
end
