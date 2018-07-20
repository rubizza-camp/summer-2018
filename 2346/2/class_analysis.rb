require 'pathname'
require_relative 'class_rapper'
require_relative 'third_level'

# class to analyze texts
class Analysis
  def self.first_level(lim)
    rappers_hash = BadRappersHash.new
    rappers_array = rappers_hash.array_as_result
    if lim <= rappers_array.size
      lim.times { |ind| rappers_array[ind].print }
    else
      rappers_array.each(&:print)
    end
  end

  def self.second_level(name, quantity)
    rappers_hash = RappersHashWithDictionary.new
    rappers_hash.result_for_second(name, quantity)
  end
end

def find_files
  Pathname('./rap-battles/').children
end

module BaseRappersHash
  attr_reader :rappers_hash

  UNWANTEDBEGIN = %r{(\./rap-battles/) ?}
  UNWANTEDEND = /( против | vs | VS ).*/

  def fill_rapper_hash
    all_paths = find_files
    all_paths.each { |path| update_hash(path.to_s) }
  end

  def find_rapper_key(rapper_name)
    rapper_name = rapper_name.downcase
    rappers_hash.keys.find do |key|
      key = key.downcase
      compare_key_and_name(key, rapper_name)
    end
  end

  def add_battle_to_existing_rapper(key, name, battle)
    rappers_hash[key].push_one_battle(battle).choose_better_name(name)
  end

  private

  def compare_key_and_name(key, name)
    name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
  end
end

class BadRappersHash
  include BaseRappersHash

  def initialize
    @rappers_hash = {}
    fill_rapper_hash
  end

  def update_hash(rapper_battle)
    rapper_name = rapper_battle.gsub(UNWANTEDBEGIN, '').gsub(UNWANTEDEND, '')
    possible_key = find_rapper_key(rapper_name)
    if possible_key
      add_battle_to_existing_rapper(possible_key, rapper_name, rapper_battle)
    else
      @rappers_hash[rapper_name] = BadRapper.new(rapper_name, rapper_battle)
    end
  end

  def array_as_result
    rappers_hash.values.sort_by(&:count_words).reverse
  end
end

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
    possible_key = find_rapper_key(rapper_name)
    if possible_key
      add_battle_to_existing_rapper(possible_key, rapper_name, rapper_battle)
    else
      @rappers_hash[rapper_name] = Rapper.new(rapper_name, rapper_battle)
    end
  end

  def print_dictionary(quantity)
    dict.sort_by { |word| word[1] }.last(quantity).reverse_each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
  end

  def array_with_exceptions
    IO.foreach('./exceptions.txt') { |line| @exclude_array << line.delete("\n") }
  end

  def result_for_second(name, quantity)
    possible_key = find_rapper_key(name)
    if possible_key
      count_top_words(rappers_hash[possible_key], quantity)
    else
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      rappers_hash.keys.each { |key| puts key }
    end
  end

  def count_top_words(rapper, quantity)
    array_with_exceptions
    rapper.battles.each { |battle_name| count_top_words_in_line(battle_name) }
    print_dictionary(quantity)
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
end
