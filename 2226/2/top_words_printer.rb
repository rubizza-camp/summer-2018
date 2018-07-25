# This class print top words to the terminal
class TopWordsPrinter
  def initialize(top_words, rapper_name)
    @top_words = top_words
    @name = rapper_name
    @rappers_storage = DataStorage.list_all_rappers
    print_top_words(@top_words, @name)
  end

  def print_top_words(top_words, name)
    if @rappers_storage.include?(name)
      Rapper.new(name).the_most_used_words(top_words).each do |elem|
        puts "#{elem[0]} - #{elem[1]} #{Russian.p(elem.last, 'раз', 'раза', 'раз')}"
      end
    else
      puts "Репер #{name} не известен мне. Зато мне известны: "
      puts @rappers_storage
    end
  end
end
