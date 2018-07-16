require 'io/console'
require 'optparse'
require 'russian_obscenity/base'
require 'docopt'

# 1st tas
class TopBadWords
  def initialize(number)
    foul_language(number)
  end

  def foul_language(number)
    find_members_name
    sort_result
    number.to_i.times do |num|
      out = Output.new
      out.first_result_output(@members[num])
      puts
    end
  end

  def find_members_name
    @members = []
    Dir.foreach('versus-battle') do |file|
      for_delete = file[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
      member_name = file.chomp(for_delete)
      verification_of_existence(member_name, file)
    end
  end

  def verification_of_existence(member_name, file)
    return member_name if member_name.include?('.') || member_name.include?('..')
    new_member(member_name) unless search_in_bad_words_array(member_name)
    temp = @members.index(search_in_bad_words_array(member_name))
    add_info(@members[temp], file)
  end

  def new_member(member_name)
    member = {}
    member[:name] = member_name
    create_cases(member)
    @members << member
  end

  def create_cases(member)
    member[:battles] = 0
    member[:bad_words] = 0
    member[:avr_words] = 0
    member[:words_per_round] = 0
    member[:rounds] = 0
  end

  def search_in_bad_words_array(member_name)
    @members.detect { |mem| mem[:name] == member_name }
  end

  def add_info(member, file)
    member[:battles] += 1
    member[:rounds] += 1
    find_bad_words(member, file)
    battle_analysis(member, file)
  end

  def find_bad_words(member, file)
    Dir.chdir('versus-battle')
    IO.foreach(file) do |line|
      temp = RussianObscenity.find(line)
      member[:bad_words] += temp.size
      member[:bad_words] += 1 if (/[\*]/ =~ line)
    end
  end

  def battle_analysis(member, file)
    word_per_battle = []
    IO.foreach(file) do |line|
      rounds_counter(member, line)
      word_per_battle << words_counter_at_the_tail(line)
    end
    word_per_battle.flatten!
    words_number_in_battle(member, word_per_battle)
    words_number_in_rounds(member, word_per_battle)
    Dir.chdir('..')
  end

  def rounds_counter(member, line)
    member[:rounds] += 1 unless line.scan(/^(Раунд \d+)/).empty?
  end

  def words_counter_at_the_tail(line)
    line.scan(/[А-яёA-z]+/)
  end

  def words_number_in_battle(member, words_array)
    number = words_array.size
    member[:avr_words] = number / member[:battles] if member[:avr_words].zero?
    member[:avr_words] = (number / member[:battles] + member[:avr_words]) / 2.0 unless member[:avr_words].zero?
  end

  def words_number_in_rounds(member, words_array)
    number = words_array.size
    return member[:words_per_round] = number / member[:rounds] if member[:words_per_round].zero?
    return member[:words_per_round] = (number / member[:rounds] + member[:words_per_round]) / 2.0 unless member[:words_per_round].zero?
  end

  def sort_result
    @members.sort_by! { |key| key[:bad_words] * -1 }
  end
end

class TopWords
  def initialize(name, number = 30)
    favourite_words(name, number)
  end

  def favourite_words(name, number)
    @words = []
    member_exist(name)
    sorted = words_sort
    out = Output.new
    out.second_result_output(number, sorted) unless @words.empty?
    output_all_members(name) if @words.empty?
  end

  def member_exist(name)
    Dir.foreach('versus-battle') do |file|
      for_delete = file[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
      member_name = file.chomp(for_delete)
      word_analysis(file) if name == member_name[1..-1]
    end
  end

  def word_analysis(file)
    words_array = []
    Dir.chdir('versus-battle')
    IO.foreach(file) do |line|
      words_array << line.scan(/[А-яёA-z\d]+[^\s,\.\-\?\!]*/i)
    end
    words_array_pretty_view(words_array)
    words_often(words_array)
    Dir.chdir('..')
  end

  def words_array_pretty_view(array)
    array.flatten!
    array.map(&:downcase!)
  end

  def words_often(arr)
    arr.each do |word|
      new_word(word) unless search_in_words_array(word)
      temp = @words.index(search_in_words_array(word))
      @words[temp][word.to_sym] += 1
    end
  end

  def search_in_words_array(word)
    @words.detect { |mem| mem[word.to_sym] }
  end

  def output_all_members(name)
    puts "Рэпер #{name} не известен мне. Зато мне известны:"
    all_members_names
  end

  def all_members_names
    Dir.foreach('versus-battle') do |file|
      for_delete = file[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
      puts file.chomp(for_delete) unless file.include?('.') || file.include?('..')
    end
  end

  def words_sort
    temp = []
    @words.each { |elem| temp << elem.to_a }
    temp.flatten!(1)
    temp.sort! { |first, second| (first[1] <=> second[1]) * -1 }
  end

  def new_word(word)
    new_word = {}
    new_word[word.to_sym] = 0
    @words << new_word
  end
end

class Output
  def first_result_output(member)
    printf('%-25s ', member[:name])
    printf('| %-2d battles ', member[:battles])
    printf('| %-4d  total bad words ', member[:bad_words])
    printf('| %-3.2f  bad words per battle ', member[:avr_words])
    printf('| %-4d  words per round', member[:words_per_round])
  end

  def second_result_output(number, arr)
    number.to_i.times do |num|
      puts "#{arr[num][0]} - #{arr[num][1]} times"
    end
  end
end

def file_analysis
  doc = %{
  Battle analysis

  Usage:
    #{__FILE__} --top-bad-words=<top_bad_words_number>
    #{__FILE__} --top-words=<top_words_number> --name=<name>
    #{__FILE__} --name=<name>

  Options:
    --top-bad-words=<top_bad_words_number>
    --top-words=<top_words_number>
    --name=<name>
  }
  call_doc(doc)
end

def call_doc(doc)
  begin
    args = Docopt.docopt(doc)
  rescue Docopt::Exit => exp
    puts exp.message
    exit
  end
  call_method(args)
end

def call_method(args)

  TopBadWords.new(args['--top-bad-words'].to_s) if args['--top-bad-words']
  TopWords.new(args['--name'].to_s, args['--top-words'].to_s) if args['--top-words']
  TopWords.new(args['--name'].to_s) if args['--name'] && !args['--top-words']
end

file_analysis
