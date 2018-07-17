# Organizes top_words list and leads it to a good form to output
class TopBadWordsOrganizer
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(battles_analyzer, words_analyzer, number)
    @battles_analyzer = battles_analyzer
    @words_analyzer = words_analyzer
    @number = number
  end

  def organize
    words = @words_analyzer.words
    bad_words = @words_analyzer.bad_words
    battles = @battles_analyzer.battles
    rounds = @battles_analyzer.rounds
    fill_list(words, bad_words, battles, rounds)
  end

  private

  def fill_list(words, bad_words, battles, rounds)
    list = {}
    bad_words.each do |name, bad_words_number|
      list.merge!(name => { battles: battles[name],
                            bad_words: bad_words_number,
                            bad_words_per_battle: bad_words_number.fdiv(battles[name]),
                            words_per_round: words[name].fdiv(rounds[name]) })
    end
    list = sort(list)
    delete_excess(list)
  end

  def sort(list)
    list = list.sort_by { |element| element[1][:bad_words_per_battle] }
    list.reverse.to_h
  end

  def delete_excess(list)
    counter = 0
    list.delete_if { (counter += 1) > number }
    list
  end
end

# Organizes top_words list and leads it to a good form to output
class TopWordsOrganizer < TopBadWordsOrganizer
  attr_reader :battles_analyzer, :words_analyzer, :number, :name
  attr_reader :list

  def initialize(each_word_analyzer, number)
    @each_word_analyzer = each_word_analyzer
    @number = number
  end

  def organize
    list = @each_word_analyzer.each_word
    fill_list(list)
  end

  private

  def fill_list(list)
    disabled_words_list = scan_dictionary
    list.each do |name, words_hash|
      list[name] = sort(words_hash, disabled_words_list)
      list[name] = delete_excess(list[name])
    end
  end

  def scan_dictionary
    disabled_words_list = []
    dictionary = File.open('disabled_words_dictionary')
    dictionary.each { |word| disabled_words_list << word.match(/.*(?=\n)/).to_s }
    disabled_words_list
  end

  def sort(words_hash, disabled_words_list)
    words_hash.delete_if { |word| disabled_words_list.include?(word.to_s) }
    words_hash = words_hash.sort_by { |element| element[1] }
    words_hash.reverse.to_h
  end
end

# Prints organized top_bad_words list
class TopBadWordsPrinter
  def print_result(list)
    print_border
    list.each do |name, info|
      printf("| %-25s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
             name.to_s + ':', info[:battles], info[:bad_words], info[:bad_words_per_battle], info[:words_per_round])
    end
    print_border
  end

  private

  def print_border
    print '+---------------------------+------------+-------------------'
    print "---+------------------------------+--------------------------+\n"
  end
end

# Prints organized top_words list
class TopWordsPrinter
  def print_result(list)
    list.each do |name, words_hash|
      print_name(name)
      print_core(words_hash)
    end
    print_border
  end

  private

  def print_border
    puts '+-----------------+-------------+'
  end

  def print_core(words_hash)
    words_hash.each { |word, num| printf("| %-15s | %3d times   |\n", word, num) }
  end

  def print_name(name)
    print_border
    printf("| %-29s |\n", name.to_s + ':')
    print_border
  end
end
