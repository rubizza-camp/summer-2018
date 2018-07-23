# This is module Helper
module Helper
  def self.clearing_text_from_garbage(text)
    arr_words = text.delete(",.!?\"\':;«»").split(' ')
    arr_words.select! { |word| word.size > 3 }
  end

  def self.formatting_word_say(word)
    "#{word} #{Russian.p(word, 'слово', 'слова', 'слов', 'слов')}"
  end

  def self.formatting_word_battle(word)
    "#{word} #{Russian.p(word, 'баттл', 'баттла', 'баттлов')}"
  end

  def self.formatting_word_obscence_word(word)
    "#{word} #{Russian.p(word, 'нецензурное слово', 'нецензурных слова',
                         'нецензурных слов')}"
  end

  def self.find_rapper_battles(battles, raper_name)
    battles.select do |battle|
      battle.name.split('против').first.include? raper_name
    end
  end

  def self.find_names(titles)
    titles.split(/против|vs/i, 2).map do |title|
      title.strip.gsub(/\(.*\)/, '').strip
    end
  end

  def self.merge_similar_names(names)
    names.select! do |name|
      name unless names.include?(name[0..(name.size / 2)]) && name.size < 3
    end
  end
end
