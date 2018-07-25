module TopWordParams
  PREPOSITIONS = 'prepositions'.freeze

  def initialize_top_words(battle)
    prepositions = File.read(PREPOSITIONS).split(',')
    words = battler_words(battle).map do |word, appearances|
      TopWord.new(word, appearances) unless prepositions.include?(word)
    end
    words.compact.sort_by(&:appearances).reverse
  end

  def text_battler(name)
    DirectoryHelper.take_all_battles.each_with_object([]) do |battle, texts|
      texts << DirectoryHelper.take_text_battler(battle) if name_battler(battle).eql?(name)
    end
  end

  private

  def battler_words(battle)
    battle.split.each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1 }
  end

  def name_battler(title)
    title.split('против')[0].strip
  end
end
