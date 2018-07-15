class TopWordsAnalizator
  # This method smells of :reek:TooManyStatements
  def search_top_words_for_participant(name, names_of_files, num_for_output)
    counts = {}
    # remove excess symbols
    words = find_all_words(name, names_of_files).map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
    words = rm_excess_words(words).each { |word| counts[word] = words.count(word) unless counts.include?(word) }
    counts = counts.sort_by { |_key, value| value }.reverse
    output_words(counts, num_for_output)
  end

  private

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def find_all_words(name, names_of_files)
    words = []
    names_of_files.each do |f_name|
      words += read_words(f_name) if f_name.include?(name) && (f_name.index(name) == f_name.index('/') + 2 ||
                                    f_name.index(name) == f_name.index('/') + 1)
    end
    words
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def read_words(name_of_file)
    text = ''
    raund_text = ''
    fname = File.open(name_of_file, 'r')
    fname.each_line { |line| identify_round(text, raund_text, line) }
    text << raund_text
    fname.close
    text = Unicode.downcase(text).split(' ').select { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
  end

  # rubocop:disable RedundantMatch
  # This method smells of :reek:UtilityFunction
  def identify_round(content, raund_content, line_of_battle)
    if line_of_battle.match(/Раунд [1|2|3][^\s]*/)
      content << raund_content
    else
      raund_content << line_of_battle + ' '
    end
  end
  # rubocop:enable RedundantMatch

  # This method smells of :reek:ControlParameter
  def check_noun(word)
    noun_is_find = false
    file = File.open('word_rus.txt', 'r')
    file.each_line { |line| noun_is_find = true if word == line.chop! }
    noun_is_find
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:UtilityFunction
  def rm_excess_words(words)
    words.each { |word| words.delete(word) if word.size < 3 }
    words = words.reject(&:nil?)
    words.each { |word| words.delete(word) if !check_noun(word) }
    words = words.reject(&:nil?)
  end

  # This method smells of :reek:FeatureEnvy
  def output_words(counts_of_words, num_for_output)
    num_for_output.times do
      word_with_count = counts_of_words.shift
      puts word_with_count[0] + ' - ' + word_with_count[1].to_s + ' раз'
    end
  end
end
