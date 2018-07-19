# Class that delegates to Handler and produces output
class Printer
  def print_top_rude_rappers(rappers_hash)
    print_rude_rappers_border
    rappers_hash.each { |name, obj| RudeRappersBodyPrinter.new(name, obj).print_body }
    print_rude_rappers_border
  end

  def print_top_words(rappers_hash)
    rappers_hash.each do |name, words_hash|
      print_top_words_name(name)
      print_top_words_body(words_hash)
    end
    print_top_words_border
  end

  private

  def print_rude_rappers_border
    print '+----------------------------+------------+-------------------'
    print "---+------------------------------+--------------------------+\n"
  end

  def print_top_words_border
    puts '+-----------------+-------------+'
  end

  def print_top_words_name(name)
    print_top_words_border
    printf("| %-29s |\n", name.to_s + ':')
    print_top_words_border
  end

  def print_top_words_body(words_hash)
    words_hash.each { |word, num| printf("| %-15s | %3d times   |\n", word, num) }
  end
end

# Class, that produce body output to Printer class
class RudeRappersBodyPrinter
  def initialize(name, obj)
    @name = name
    @obj = obj
  end

  def print_body
    printf("| %-26s | %-2d battles | %-4d total bad words | %-7.2f bad words per battle | %-8.2f words per round |\n",
           @name.to_s + ':', @obj.number_of_battles, @obj.number_of_obscene_words,
           @obj.obscene_words_per_battle, @obj.words_per_round)
  end
end
