# This class print top words to the terminal
class TopWordsPrinter
  def initialize(top_words, raper_name)
    @top_words = top_words
    @name = raper_name
    @rapers_storage = ListOfRapers.list_all_rapers
    print_top_words(@top_words, @name)
  end

  def print_top_words(top_words, name)
    if @rapers_storage.include?(name)
      Raper.new(name).the_most_used_words(top_words).each do |elem|
        puts "#{elem[0]} - #{elem[1]} #{Russian.p(elem.last, 'раз', 'раза', 'раз')}"
      end
    else
      puts "Репер #{name} не известен мне. Зато мне известны: "
      puts @rapers_storage
    end
  end
end
