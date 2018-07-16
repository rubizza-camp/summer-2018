require 'pathname'
require_relative 'class_rapper'

# class to analyze texts
class Analysis
  def first_level(lim)
    rappers_array = {}.create_rapper_hash.create_result_array
    lim <= rappers_array.size ? lim.times { |ind| rappers_array[ind].print } : rappers_array.each(&:print)
  end

  def second_level(name, qty)
    {}.create_rapper_hash.result_for_second(name, qty)
  end
end

# special Hash
class Hash
  def find_files
    pn = Pathname('./rap-battles/')
    all_paths = pn.children
    all_paths
  end

  def create_rapper_hash
    rappers_hash = {}
    all_paths = find_files
    all_paths.each do |path|
      rappers_hash = rappers_hash.update_hash(path.to_s)
    end
    rappers_hash
  end

  def rapper_key?(rapper_name)
    rapper_name = rapper_name.downcase
    keys.find do |key|
      key = key.downcase
      compare_key_and_name(key, rapper_name)
    end
  end

  def compare_key_and_name(key, name)
    name =~ /^#{key}.*/ || key =~ /^#{name}.*/ || name.chop == key.chop
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
  end

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
    end
  end
end

# special Hash
class Hash
  def count_top_words(rapper, qty)
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
  end

  def print_dictionary(qty)
    sort { |wordx, wordy| wordy[1] <=> wordx[1] }.first(qty).each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
  end

  def array_with_exceptions
    arr = []
    IO.foreach('./exceptions.txt') { |line| arr << line.delete("\n") }
    arr
  end
end
