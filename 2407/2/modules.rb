# Contains all methods without instance
module SomeMethods
  def self.prepare_battlers_table(battlers)
    find_all_battlers.each { |battler_name| battlers << process_battler(battler_name) }
    battlers = battlers.sort_by! { |battler| battler.words_data[1] }.reverse!
    battlers
  end

  def self.find_all_battlers
    battlers = []
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob('*против*').each do |title|
        battlers << title.split('против').first.strip
      end
    end
    battlers.uniq
  end

  def self.process_battler(battler)
    battles_titles = take_battles_titles(battler)
    total_bad_words = count_total_bad_words(battler)
    words_in_round = count_words_in_each_battle(battler)
    average_bad_words_number = avg_number(total_bad_words, battles_titles)
    Battler.new(battler, battles_titles.size, total_bad_words, average_bad_words_number, words_in_round)
  end

  def self.count_total_bad_words(battler)
    BadWordsCounter.count(take_battles_titles(battler))
  end

  def self.count_words_in_each_battle(battler)
    TotalWordsInRoundCounter.count(take_battles_titles(battler))
  end

  def self.avg_number(total_bad_words, battles_titles)
    (total_bad_words.to_f / battles_titles.size).round(2)
  end

  def self.take_battles_titles(battler)
    battles_titles = []
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob("*#{battler}*").each do |title|
        battles_titles << title if title.split('против').first.include? battler
      end
    end
    battles_titles
  end

  # This method smells of :reek:DuplicateMethodCall
  def self.get_battler_as_row(battler)
    row = []
    row += [battler.name.to_s, "#{battler.words_data[0]} баттлов", "#{battler.words_data[1]} нецензурных слов"]
    row += ["#{battler.words_data[2]} слова на баттл", "#{battler.words_data[3]} слов в раунде"]
    row
  end
end
