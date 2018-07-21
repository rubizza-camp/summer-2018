require_relative 'PrintBestWord'
# This class checks the entered name with the list
# of participants and make the appropriate action
class TopWordsLike < PrintBestWord
  def self.top_best_words(name)
    if name_batlers.include?(name)
    then best_word_list(RapersArray.battle_men_array, name)
    else
      name_battle(name)
    end
  end
end
