class TopWordsAnalizator
  
  def initialize
    @counts = {}
  end  

  def search_top_words_for_the_participant(participant_name, file_names, num_for_output)
    make_counts(participant_name, file_names)
    @counts = @counts.sort_by { |_key, value| value }.reverse
    output_words(num_for_output)
  end

  def self.print_top_words(word_with_count)
    puts "#{word_with_count[0]} - #{word_with_count[1]} раз"
  end

  private

  def make_counts(name, file_names)
    words = find_all_words(name, file_names)
    remove_excess_symbols(words).each { |word| words.delete(word) if word.size < 3 || !check_noun(word) }
    words.reject(&:nil?).map! { |word| @counts[word] = words.count(word) unless @counts.include?(word) }
  end

  def find_all_words(name, file_names)
    words = []
    file_names.each do |file_name|
      words += read_words(file_name) if check_if_the_right_battle(file_name, name)
    end
    words
  end

  def check_if_the_right_battle(file_name, name)
    file_name[file_name.index('/') + 1..-1].strip.index(name) == 0
  end

  def read_words(name_of_file)
    text = ''
    round_text = ''
    File.open(name_of_file, 'r').each_line { |line| define_round(text, round_text, line) }
    make_words(text, round_text)
  end

  def define_round(content, round_content, line_of_battle)
    if line_of_battle.match(/Раунд [1|2|3][^\s]*/) && round_content != ''
      content << round_content
    else
      round_content << line_of_battle + ' '
    end
  end

  def make_words(text, round_text)
    text << round_text
    Unicode.downcase(text).split(' ').select { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
  end

  def remove_excess_symbols(words)
    words.map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end

  def check_noun(word)
    noun_is_find = false
    File.open('word_rus.txt', 'r').each_line do |line|
      noun_is_find = line.chop!.eql?(word)
      break if noun_is_find
    end
    noun_is_find
  end

  def output_words(num_for_output)
    num_for_output.times do
      word_with_count = @counts.shift
      TopWordsAnalizator.print_top_words(word_with_count)
    end
  end
end
