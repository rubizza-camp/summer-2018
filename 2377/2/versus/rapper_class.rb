class Rapper
  attr_accessor :name, :battles, :bad_words, :words_per_round, :words_per_battle, :fav_words

  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @bad_words = 0
    @rounds = 0
    @words = 0
    @file_array = [] # тут лежат строки строки строки 
    @words_per_round = 0
    @battles = 1
    @fav_words = {}
  end
 
  # тут что-то не очень красиво 
  def count_bad_words(filename)
    bad_words = 0
    word_array = []
    read_file(filename)
    @file_array.each do |line|
      word_array += line.split
    end
    word_array.each do |word|
      bad_words += 1 if RussianObscenity.obscene?(word) || word[/\W*\*\W*/]
    end
    @bad_words += bad_words
  end
  
  # сделать так как хотел ментор и посмотреть вообще на этот метод что-то он какой-то странный
  def read_file(filename) # исправить на inject
    @file_array.clear
    File.foreach filename do |line|
       @file_array.push(line)
     end
  end
    
  def count_rounds_and_words(filename)
    words_array = []
    read_file(filename)
    count_rounds
    count_words(words_array)
    rounds_check
  end
  # сделать чтобы регексп большой не повторялся дважды
  
  def count_rounds
    rounds = @file_array.count { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
    @rounds += rounds
  end

  def count_words(words_array)
    words = []
    words_array = @file_array.delete_if { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
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
# ПОЧИНИТЬ СИМПЛ ВОРД ДИКШИОНАРРИ ПОЧЕМУ ОН НЕ РАБОТАЕТ ПОЧЕМУ ПОЧЕМУ ПОЧЕМУ ААААААААААА

  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  def find_favourite_words(filename)
  fav_words = Hash.new 0
  word_array = []
  not_counting = ['не', 'в', 'и', 'ты', 'я', 'что', 'на', 'с', '-', 'как', 'это', 'тебя', 'меня', 'он', 'за', 'мне', 'все', 'бы', 'кто', 'был', 'про', 'же', 'а', 'просто', 'так', 'его', 'от', 'мой', 'вы', 'по', 'если', 'твой', 'из', 'тебе', 'есть', 'то', 'к', 'тут', 'даже', 'под', 'но', '–', 'у', 'ведь', 'мы', 'для', 'где', 'вот', 'только', 'здесь', 'чтобы', 'до', 'там', 'или', 'чем', 'когда', 'ты,', 'все', 'быть', 'нет,', 'ни', 'тоже', 'ну', 'лишь', 'потому', 'еще', 'без', 'почему', 'было', 'будет', 'нет', 'со', 'всех', 'будто', 'раз', 'этом', 'то,', 'после', 'пока', 'твоя', 'лет', 'их', 'сколько', 'о', 'хоть', 'да', 'она', 'б', 'теперь', 'вам', 'чтоб', 'ему', 'этот', 'себя', 'него', 'я,', 'ли', 'такой', 'тебя,', 'твоих', 'вас', 'назад', 'во', 'всего', 'об', 'них', 'им', 'сам', 'тот', 'свой', 'этим', 'хотя', 'себе', 'нам', 'моя', '', 'всё', 'может', 'тех', 'твои', 'каждый', 'тем', 'тобой', 'сюда', 'они', 'уже', 'вообще', 'сейчас', 'сегодня', 'всю', 'итак', 'том', 'кстати', 'против', 'твоей', 'твою', 'твоего', 'её', 'словно', 'вместо', 'этой', 'короче', 'типа', 'ее', 'между', 'твое', 'нас', 'какой', 'надо', 'ей', 'столько', 'всем', 'перед', 'итоге', 'мной', 'мои', 'больше', 'ещё', 'значит', 'настолько', 'лучше', 'сразу', 'при', 'свою', 'своей', 'пор', 'ним', 'давай']
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
