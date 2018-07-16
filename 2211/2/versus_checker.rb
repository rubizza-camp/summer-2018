require 'io/console'
require 'optparse'
require 'russian_obscenity/base'

# 1st tas
class TopBadWords
  def initialize(number)
    foul_language(number)
  end

  def foul_language(number)
    find_members_name
    sort_result(@members)
    number.to_i.times do |num|
      result_output(num)
    end
  end

  def result_output(number)
      printf('%-25s ', @members[number][:name])
      printf('| %-2d battles ', @members[number][:battles])
      printf('| %-4d  total bad words ', @members[number][:bad_words])
      printf('| %-3.2f  bad words per battle ', @members[number][:average_number_in_the_battle])
      printf('| %-4d  words per round\n', @members[number][:words_per_round])
  end

  def sort_result(arr)
    arr.sort_by! { |k| k[:bad_words] * -1 }
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
    return member_name if member_name.iclide?('.') || member_name.include?('..')
    new_member(member_name) if search_in_bad_words_array(member_name).nil?
    temp = @members.index(search_in_bad_words_array(member_name))
    add_info(@members[temp], file)
  end

  def search_in_bad_words_array(member_name)
    @members.detect { |mem| mem[:name] == member_name }
  end

  def new_member(member_name)
    member = {}
    member[:name] = member_name
    member[:battles] = 0
    member[:bad_words] = 0
    member[:average_number_in_the_battle] = 0
    member[:words_per_round] = 0
    member[:rounds] = 0
    @members << member
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
      member[:bad_words] += 1 unless (/[\*]/ =~ line).nil?
    end
  end

  def bad_words_initialize
    @bad_words = []
    IO.foreach('bad_words') do |line|
      @bad_words << line.scan(/[А-яёA-z\d]{2,}[^\s,]*/)
    end
    @bad_words.flatten!
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

  def words_number_in_battle(member, words_array)
    number = words_array.size
    member[:average_number_in_the_battle] = number / member[:battles] if member[:average_number_in_the_battle].zero?
    member[:average_number_in_the_battle] = (number / member[:battles] + member[:average_number_in_the_battle]) / 2.0 unless member[:average_number_in_the_battle].zero?
  end

  def words_counter_at_the_tail(line)
    line.scan(/[А-яёA-z]+/)
  end

  def rounds_counter(member, line)
    member[:rounds] += 1 unless line.scan(/^(Раунд \d+)/).empty?
  end

  def words_number_in_rounds(member, words_array)
    number = words_array.size
    return member[:words_per_round] = number / member[:rounds] if member[:words_per_round].zero?
    return member[:words_per_round] = (number / member[:rounds] + member[:words_per_round]) / 2.0 unless member[:words_per_round].zero?
end

class TopWords
  def initialize(number, name)
    favourite_words(number, name)
  end

  def favourite_words(number, name)
    @words = []
    member_exist(name)
    call_sorted_words(number) unless @words.empty?
    output_all_members(name) if @words.empty?
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
    @words.each { |el| temp << el.to_a }
    temp.flatten!(1)
    temp.sort! { |a, b| (a[1] <=> b[1]) * -1 }
  end

  def call_sorted_words(number)
    temp = words_sort
    number.to_i.times do |i|
      puts "#{temp[i][0]} - #{temp[i][1]} times"
    end
  end

  def word_analysis(file)
    words_array = []
    Dir.chdir('versus-battle')
    IO.foreach(file) do |line|
      words_array << line.scan(/[А-яёA-z\d]+[^\s,\.\-\?\!]*/i)
    end
    words_array.flatten!
    words_array.map(&:downcase!)
    words_often(words_array)
    Dir.chdir('..')
  end

  def words_often(arr)
    arr.each do |word|
      new_word(word) if search_in_words_array(word).nil?
      temp = @words.index(search_in_words_array(word))
      @words[temp][word.to_sym] += 1
    end
  end

  def search_in_words_array(word)
    @words.detect { |mem| mem[word.to_sym] }
  end

  def new_word(w)
    new_word = {}
    new_word[w.to_sym] = 0
    @words << new_word
  end

  def member_exist(name)
    Dir.foreach('versus-battle') do |file|
      for_delete = file[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
      member_name = file.chomp(for_delete)
      word_analysis(file) if name == member_name[1..-1]
    end
  end
end

def file_analysis
  require 'docopt'
  doc = %{
  Battle analysis
  
  Usage:
    #{__FILE__} --top-bad-words=<top_bad_words_number>
    #{__FILE__} --top-words=<top_words_number> --name=<name>

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
  TopWords.new(args['--top-words'].to_s, args['--name'].to_s) if args['--top-words']
end

file_analysis
