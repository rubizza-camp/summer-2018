# Fetch data about raper
class Raper
  attr_reader :raper
  def initialize(name, rap_files = nil)
    @raper = { name: name, rap_files: rap_files, bad_words: nil,
               count_rounds: nil, count_words_in_round: nil }
  end

  def count_rounds
    @raper[:count_rounds] ||= fetch_count_rounds
  end

  def count_words_in_round
    @raper[:count_words_in_round] ||= fetch_count_words_in_round
  end

  def bad_words
    @raper[:bad_words] ||= BadWord.new(@raper[:rap_files]).fetch_bad_words
  end

  def avg_words_battle
    averaged = @raper[:bad_words].size / 1.0 / @raper[:rap_files].size
    averaged = averaged.round(2)
    sugar = Russian.p(averaged, 'слово', 'слова', 'слов', 'слов')
    "#{averaged.to_s.ljust(6)} #{sugar} на баттл".ljust(20)
  end

  def avg_words_rounds
    avg_words = (count_words_in_round / 1.0 / count_rounds).round(2)
    sugar = Russian.p(avg_words, 'слово', 'слова', 'слов', 'слов')
    "#{avg_words.to_s.ljust(7)} #{sugar} в раунде"
  end

  def show
    word_batl = Russian.p(@raper[:rap_files].size, 'баттл', 'баттла', 'баттлов')
    foul_lang = Russian.p(@raper[:bad_words].size, 'нецензурное слово',
                          'нецензурных слова', 'нецензурных слов')
    col_two   = "#{@raper[:rap_files].size.to_s.ljust(3)} #{word_batl}"
    col_three = "#{format('%3s ', @raper[:bad_words].size)} #{foul_lang}"
    result_show(col_two, col_three)
  end

  def result_show(col_two, col_three)
    col_one = @raper[:name].ljust(25)
    col_two = col_two.ljust(12)
    col_three = col_three.ljust(25)
    "#{col_one} | #{col_two} | #{col_three} | #{avg_words_battle} | " +
      avg_words_rounds
  end

  def show_favorite_words(before_n = 30)
    favorites = FavoriteWord.new(@raper[:rap_files]).fetch_favorite_words
    arr = favorites.sort_by { |_word, counter| 1 - counter }[0...before_n]
    arr.each { |key, value| puts "#{key} - #{value}" }
  end

  def self.all
    obj_rapers = []
    DataBattle.new.fetch_rapers.each do |name, files|
      obj_rapers.push(Raper.new(name, files))
    end
    obj_rapers
  end

  def fetch_files
    @raper[:rap_files] = DataBattle.fetch_files_one_raper(@raper[:name])
  end

  def self.the_most_obscene_rappers(quantity = nil)
    rap_objects = Raper.all
    quantity ||= rap_objects.size
    obj_sort = rap_objects.sort_by do |obj|
      1 - obj.bad_words.size
    end[0..(quantity - 1)]
    show_stats(obj_sort)
  end

  def self.show_stats(obj_raper)
    obj_raper.each { |obj| puts obj.show }
  end

  def self.show_all_names
    DataBattle.new.fetch_rapers.each_key { |key| puts key }
  end

  def self.raper?(raper)
    !Dir.glob("#{DataBattle::FOLDER}/*#{raper}*").size.zero?
  end

  private

  def fetch_count_words_in_round
    Round.new(@raper[:rap_files]).fetch_data[:count_words]
  end

  def fetch_count_rounds
    Round.new(@raper[:rap_files]).fetch_data[:count_rounds]
  end
end
