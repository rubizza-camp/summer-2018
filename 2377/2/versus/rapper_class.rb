class Rapper
  attr_accessor :name, :battles, :bad_words, :words_per_round, :words_per_battle, :fav_words

  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @bad_words = 0
    @rounds = 0
    @words = 0
    @words_per_round = 0
    @battles = 1
    @fav_words = {}
  end

  def count_bad_words(filename)
    bad_words = 0
    word_array = []
    file_array = []
    read_file(filename, file_array)
    file_array.each do |line|
      word_array += line.split
    end
   @bad_words += word_array.count { |w| RussianObscenity.obscene?(w) || w[/\W*\*\W*/] }
  end
  
  # сделать так как хотел ментор и посмотреть вообще на этот метод что-то он какой-то странный
  def read_file(filename, file_array) # исправить на inject
    File.foreach filename do |line|
       file_array.push(line)
     end
  end
    
  def count_rounds_and_words(filename)
    words_array = []
    file_array = []
    read_file(filename, file_array)
    count_rounds(file_array)
    count_words(words_array, file_array)
    rounds_check
  end
  # сделать чтобы регексп большой не повторялся дважды
  
  def count_rounds(file_array)
    rounds = file_array.count { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
    @rounds += rounds
  end

  def count_words(words_array, file_array)
    words = []
    words_array = file_array.delete_if { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
    words_array.each do |line|
      words += line.split
    end
    @words += words.size
  end

  def rounds_check
    @rounds = 1 if @rounds == 0
  end

  def count_words_per_round(filename)
    count_rounds_and_words(filename)
    @words_per_round = @words / @rounds
  end

  def count_words_per_battle
    @words_per_battle = @bad_words / @battles
  end

# разбить на методы поменьше
  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  def find_favourite_words(filename)
  fav_words = Hash.new 0
  word_array = []
  buf = []
  not_counting = []
  read_file('simple_words_dictionary.txt', buf)
    buf.each do |line|
      not_counting += line.split
    end
    File.foreach filename do |line|
      word_array += line.split
    end
    word_array.map!(&:downcase)
    word_array.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    word_array.delete_if { |word| not_counting.include?(word) }
    word_array.each { |word| fav_words[word] += 1 }
    @fav_words.merge!(fav_words) { |_key, first, second| first + second }
    sort_fav_words
  end



end
