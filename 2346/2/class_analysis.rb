require 'pathname'
require_relative 'class_rapper'

# class to analyze texts
class Analysis
  def self.first_level(lim)
<<<<<<< HEAD
    rappers_hash = BadRappersHash.new
    rappers_array = rappers_hash.array_as_result
=======
    rappers_array = {}.create_rapper_hash.create_result_array
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
    lim <= rappers_array.size ? lim.times { |ind| rappers_array[ind].print } : rappers_array.each(&:print)
  end

  def self.second_level(name, qty)
<<<<<<< HEAD
    rappers_hash = RappersHashWithDictionary.new
    rappers_hash.result_for_second(name, qty)
  end
end

module BaseRappersHash
  attr_reader :rappers_hash

  UNWANTEDBEGIN = %r{(\./rap-battles/) ?}
  UNWANTEDEND = /( против | vs | VS ).*/

  def fill_rapper_hash
    all_paths = find_files
    all_paths.each { |path| update_hash(path.to_s) }
  end

  def rapper_key?(rapper_name)
    rapper_name = rapper_name.downcase
    rappers_hash.keys.find do |key|
      key = key.downcase
      compare_key_and_name(key, rapper_name)
    end
=======
    {}.create_rapper_hash.result_for_second(name, qty)
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
  end
end

<<<<<<< HEAD
  def add_battle_to_existing_rapper(key, name, battle)
    rappers_hash[key].push_one_battle(battle).choose_better_name(name)
  end

  def compare_key_and_name(key, name)
    name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
  end

=======
# special Hash
class Hash
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
  def find_files
    pn = Pathname('./rap-battles/')
    all_paths = pn.children
    all_paths
<<<<<<< HEAD
=======
  end

  def create_rapper_hash
    rappers_hash = {}
    all_paths = find_files
    all_paths.each do |path|
      rappers_hash = rappers_hash.update_hash(path.to_s)
    end
    rappers_hash
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
  end
end

<<<<<<< HEAD
class BadRappersHash
  include BaseRappersHash

  def initialize
    @rappers_hash = {}
    fill_rapper_hash
  end

  def update_hash(rapper_battle)
    rapper_name = rapper_battle.gsub(UNWANTEDBEGIN, '').gsub(UNWANTEDEND, '')
    possible_key = rapper_key?(rapper_name)
    if possible_key
      add_battle_to_existing_rapper(possible_key, rapper_name, rapper_battle)
    else
      @rappers_hash[rapper_name] = BadRapper.new(rapper_name, rapper_battle)
    end
  end

  def array_as_result
    rappers_hash.values.each(&:count_words).sort! { |one, second| second.average_bad <=> one.average_bad }
=======
  def rapper_key?(rapper_name)
    rapper_name = rapper_name.downcase
    keys.find do |key|
      key = key.downcase
      compare_key_and_name(key, rapper_name)
    end
  end

  def update_hash(rapper_battle)
    rapper_name = rapper_battle.gsub(%r{(\./rap-battles/) ?}, '').gsub(/( против | vs | VS ).*/, '')
    temp_key = rapper_key?(rapper_name)
    if temp_key
      add_battle_to_existing_rapper(temp_key, rapper_name, rapper_battle)
    else
      self[rapper_name] = BadRapper.new(rapper_name, rapper_battle)
    end
    self
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
  end

<<<<<<< HEAD
class RappersHashWithDictionary
  include BaseRappersHash
  attr_reader :dict, :exclude_array

  def initialize
    @rappers_hash = {}
    fill_rapper_hash
    @dict = {}
    @exclude_array = []
  end

  def update_hash(rapper_battle)
    rapper_name = rapper_battle.gsub(UNWANTEDBEGIN, '').gsub(UNWANTEDEND, '')
    possible_key = rapper_key?(rapper_name)
    if possible_key
      add_battle_to_existing_rapper(possible_key, rapper_name, rapper_battle)
    else
      @rappers_hash[rapper_name] = Rapper.new(rapper_name, rapper_battle)
    end
  end

  def print_dictionary(qty)
    dict.sort { |wordx, wordy| wordy[1] <=> wordx[1] }.first(qty).each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
  end

  def array_with_exceptions
    IO.foreach('./exceptions.txt') { |line| @exclude_array << line.delete("\n") }
  end

  def result_for_second(name, qty)
    possible_key = rapper_key?(name)
    if possible_key
      count_top_words(rappers_hash[possible_key], qty)
    else
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      rappers_hash.keys.each { |key| puts key }
=======
  def add_battle_to_existing_rapper(key, name, battle)
    rapper = self[key]
    rapper.push_one_battle(battle)
    rapper.choose_better_name(name)
  end

  def create_result_array
    values.each(&:count_words).sort! { |one, second| second.average_bad <=> one.average_bad }
  end

  def result_for_second(name, qty)
    temp_key = rapper_key?(name)
    if temp_key
      {}.count_top_words(self[temp_key], qty)
    else
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      keys.each { |key| puts key }
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
    end
  end

  def count_top_words(rapper, qty)
<<<<<<< HEAD
    array_with_exceptions
    rapper.battles.each { |battle_name| count_top_words_in_line(battle_name) }
    print_dictionary(qty)
=======
    exclude = array_with_exceptions
    rapper.battles.each { |battle_name| count_top_words_in_line(battle_name, exclude) }
    print_dictionary(qty)
  end

  def count_top_words_in_line(battle_name, exclude)
    dictionary = self
    IO.foreach(battle_name.to_s) { |line| dictionary = dictionary.right_top_words(line, exclude) }
  end

  def right_top_words(line, exclude)
    words = line.downcase.scan(/[ёа-яa-z\*]+/)
    words.each { |word| key?(word) && !exclude.include?(word) ? self[word] += 1 : self[word] = 1 }
    self
>>>>>>> 4554c91c72e730fc4d64ac6ea8f12591c3127c54
  end

  def count_top_words_in_line(battle_name)
    IO.foreach(battle_name.to_s) { |line| right_top_words(line) }
  end

  def right_top_words(line)
    words = line.downcase.scan(/[ёа-яa-z\*]+/)
    words.each do |word|
      unless exclude_array.include?(word)
        dict.key?(word) ? @dict[word] += 1 : @dict[word] = 1
      end
    end
  end

  private

  def compare_key_and_name(key, name)
    name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
  end

  def array_with_exceptions
    arr = []
    IO.foreach('./exceptions.txt') { |line| arr << line.delete("\n") }
    arr
  end
end
