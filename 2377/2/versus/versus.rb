# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/GuardClause

option_bad_words = ARGV[0].to_s[/(?<=--top-bad-words=)\d*/]
option_words = ARGV[0].to_s[/(?<=--top-words=)\d*/]
ARGV.each { |arg| @option_name = arg.to_s[/(?<=--name=)(\w|\d|.|\s)*/] }

@general_bad_words = [/сук([аи])?[м]?[и]?/, /бля[тд]?[ьие]?[й]?/, /(объ)?(за)?[её]ба[тнл]?[ьыаиос]?[йя]?/, /(от)?пизд[еиаы][тцшб]?[оь]?[л]?[ыи]?(ть)?/, /(о)?(на)?ху[йеия][тлвн]?[ьаиешн]?[ыеиола]?[яйгьм]?[оун]?[ыа]?[йяхе]?/, /(на)?хер[а]?/, /пидор[ауоеы]?[св]?[ыо]?(в)?/, /мраз[ьи]/, /еблан[ыоа]?[мв]?[и]?/, /ублюд[ок][киа]?[м]?/, /хуесос[ыао]?[мв]?/, /гандон[ыа]?/, /жоп[аы]/, /у[ёе]б[каоы]?[ки]?/, /\W*\*\W*/]
@words = Hash.new 0
@battles = Hash.new 0
@words_per_battle = Hash.new 0
@rounds = Hash.new { |h, k| h[k] = [0, 0] }
@words_per_round = Hash.new 0
@fav_words = Hash.new 0
# This method smells of :reek:TooManyStatements
# This method smells of :reek:NestedIterators
def count_bad_words(filename, name)
  file_array = Array.new(0)
  File.foreach filename do |line|
    file_array += line.split
  end
  bad_words_array = file_array.select { |word| @general_bad_words.any? { |exp| word[exp] } }
  @words[name] += bad_words_array.size
end

def count_words_per_battle(name)
  @words_per_battle[name] = @words[name].to_f / @battles[name]
end

def find_the_most_foul_mouthed
  @words = @words.sort_by { |_key, value| -value }.to_h
  @keys = @words.keys
end

# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:DuplicateMethodCall
def count_rounds_and_words(filename, name)
  file_array = Array.new(0)
  words = Array.new(0)

  File.foreach filename do |line|
    file_array.push(line)
  end
  rounds = file_array.count { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
  words_array = file_array.delete_if { |line| line[/((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/] }
  words_array.each do |line|
    words += line.split
  end

  @rounds[name][0] += rounds
  @rounds[name][1] += words.size
end

# This method smells of :reek:DuplicateMethodCall
def count_words_per_round(name)
  @words_per_round[name] = @rounds[name][1] / @rounds[name][0] if @rounds[name][0] != 0
  @words_per_round[name] = @rounds[name][1] if (@rounds[name][0]).zero?
end

# This method smells of :reek:TooManyStatements
# This method smells of :reek:LongParameterList
# This method smells of :reek:DuplicateMethodCall
def output(name, battles, words, words_b, round)
  printf('%-26s | ', name)
  printf('%1d баттл   | ', battles) if battles % 10 == 1 && battles != 11
  printf('%1d баттла  | ', battles) if (2..4).cover?(battles % 10) && !(12..14).cover?(battles)
  printf('%1d баттлов | ', battles) if (5..10).cover?(battles % 10) || (battles % 10).zero?
  printf('%4d нецензурное слово | ', words) if words % 10 == 1 && words != 11
  printf('%4d нецензурных слова | ', words) if (2..4).cover?(words % 10) && !(12..14).cover?(words)
  printf('%4d нецензурных слов  | ', words) if (5..10).cover?(words % 10) || (words % 10).zero? || (11..14).cover?(words)
  printf('%6.2f слова на баттл | ', words_b)
  printf("%4d слово в раунде | \n", round) if round % 10 == 1 && round != 11
  printf("%4d слова в раунде | \n", round) if (2..4).cover?(round % 10) && !(12..14).cover?(round)
  printf("%4d слов в раунде  | \n", round) if (5..10).cover?(round % 10) || (round % 10).zero? || (11..14).cover?(round)
end

# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:ControlParameter
def find_favourite_words(filename, name)
  fav_words = Hash.new 0
  word_array = []
  not_counting = ['не', 'в', 'и', 'ты', 'я', 'что', 'на', 'с', '-', 'как', 'это', 'тебя', 'меня', 'он', 'за', 'мне', 'все', 'бы', 'кто', 'был', 'про', 'же', 'а', 'просто', 'так', 'его', 'от', 'мой', 'вы', 'по', 'если', 'твой', 'из', 'тебе', 'есть', 'то', 'к', 'тут', 'даже', 'под', 'но', '–', 'у', 'ведь', 'мы', 'для', 'где', 'вот', 'только', 'здесь', 'чтобы', 'до', 'там', 'или', 'чем', 'когда', 'ты,', 'все', 'быть', 'нет,', 'ни', 'тоже', 'ну', 'лишь', 'потому', 'еще', 'без', 'почему', 'было', 'будет', 'нет', 'со', 'всех', 'будто', 'раз', 'этом', 'то,', 'после', 'пока', 'твоя', 'лет', 'их', 'сколько', 'о', 'хоть', 'да', 'она', 'б', 'теперь', 'вам', 'чтоб', 'ему', 'этот', 'себя', 'него', 'я,', 'ли', 'такой', 'тебя,', 'твоих', 'вас', 'назад', 'во', 'всего', 'об', 'них', 'им', 'сам', 'тот', 'свой', 'этим', 'хотя', 'себе', 'нам', 'моя', '', 'всё', 'может', 'тех', 'твои', 'каждый', 'тем', 'тобой', 'сюда', 'они', 'уже', 'вообще', 'сейчас', 'сегодня', 'всю', 'итак', 'том', 'кстати', 'против', 'твоей', 'твою', 'твоего', 'её', 'словно', 'вместо', 'этой', 'короче', 'типа', 'ее', 'между', 'твое', 'нас', 'какой', 'надо', 'ей', 'столько', 'всем', 'перед', 'итоге', 'мной', 'мои', 'больше', 'ещё', 'значит', 'настолько', 'лучше', 'сразу', 'при', 'свою', 'своей', 'пор', 'ним', 'давай']
  if name == " #{@option_name} "
    File.foreach filename do |line|
      word_array += line.split
    end
    word_array.map!(&:downcase)
    word_array.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    word_array.delete_if { |word| not_counting.include?(word) }
    word_array.each { |word| fav_words[word] += 1 }
    @fav_words.merge!(fav_words) { |_key, first, second| first + second }
  end
end

# This method smells of :reek:FeatureEnvy
# This method smells of :reek:DuplicateMethodCall
def second_level(word, num)
  printf("%-10s - %d слово\n", word, num) if num % 10 == 1 && num != 11
  printf("%-10s - %d слова\n", word, num) if (2..4).cover?(num % 10) && !(12..14).cover?(num)
  printf("%-10s - %d слов\n", word, num) if (5..10).cover?(num % 10) || (num % 10).zero? || (11..14).cover?(num)
end

files = Dir.glob('*[^.rb]')

files.each do |file|
  count_bad_words(file, file[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/])
  count_rounds_and_words(file, file[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/])
  find_favourite_words(file, file[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/])
end

names = files.map { |f| f[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/] }

names.each do |name|
  @battles[name] += 1
end

names.uniq.each do |name|
  count_words_per_battle(name)
  count_words_per_round(name)
end

find_the_most_foul_mouthed

unless option_bad_words.nil?
  if option_bad_words.to_i > 113
    puts 'Слишком много, столько нету.'
  else
    i = 0
    while i < option_bad_words.to_i
      output(@keys[i], @battles[@keys[i]], @words[@keys[i]], @words_per_battle[@keys[i]], @words_per_round[@keys[i]])
      i += 1
    end
  end
end

unless @option_name.nil?

  option_words = 30 if option_words.nil?

  unless names.uniq.include?(" #{@option_name} ")
    puts "Рэпер #{@option_name} мне неизвестен. Зато мне известны:"
    names.uniq.each { |name| puts name }
    option_words = nil
  end

  @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  i = 0
  while i < option_words.to_i
    second_level(@fav_words.keys[i], @fav_words[@fav_words.keys[i]])
    i += 1
  end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Style/GuardClause
