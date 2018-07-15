require 'pathname'
require_relative 'class_rapper'

# class Analysis
class Analysis
  def first_level(lim)
    rappers_array = rappers_hash_with_info.values
    rappers_array.each(&:count_words)
    rappers_array.sort! { |one, second| second.average_bad <=> one.average_bad }
    if lim <= rappers_array.size
      lim.times { |ind| rappers_array[ind].print }
    else
      rappers_array.each(&:print)
      puts "Рэперов меньше, чем #{lim}"
    end
  end

  def second_level(name, qty)
    rappers_hash = rappers_hash_with_info
    temp_key = rappers_hash.find_key_for_rapper(name)
    if temp_key
      count_top_words(rappers_hash[temp_key], qty)
    else
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      rappers_hash.keys.each { |key| puts key }
      false
    end
  end

  private

  def rappers_hash_with_info
    rappers_hash = {}
    pn = Pathname('./rap-battles/')
    all_paths = pn.children
    all_paths.each do |path|
      rapper_battle = path.to_s
      rapper_name = rapper_battle.gsub(%r{(\./rap-battles/) ?}, '')
      rapper_name = rapper_name.gsub(/( против | vs | VS ).*/, '')
      rappers_hash = rappers_hash.update_hash(rapper_name, rapper_battle)
    end
    rappers_hash
  end

  def count_top_words(rapper, qty)
    dictionary = {}
    exclude = array_with_exceptions
    rapper.battles.each do |battle_name|
      IO.foreach(battle_name.to_s) { |line| dictionary = dictionary.find_right_top_words(line, exclude) }
    end
    dictionary.print_dictionary(qty)
  end

  def array_with_exceptions
    arr = []
    IO.foreach('./exceptions.txt') { |line| arr << line.delete("\n") }
    arr
  end
end

# class Hash
class Hash
  def find_key_for_rapper(rapper_name)
    keys.find do |key|
      str_x = rapper_name.downcase
      str_y = key.downcase
      str_x =~ /^#{str_y}.*/ || str_y =~ /^#{str_x}.*/ || str_x.chop == str_y.chop
    end
  end

  def update_hash(rapper_name, rapper_battle)
    temp_key = find_key_for_rapper(rapper_name)
    if temp_key
      existing_rapper = self[temp_key]
      existing_rapper.push_one_battle(rapper_battle)
      existing_rapper.choose_better_name(rapper_name)
    else
      self[rapper_name] = Rapper.new(rapper_name, rapper_battle)
    end
    self
  end

  def find_right_top_words(line, exclude)
    words = line.downcase.scan(/[ёа-яa-z\*]+/)
    words.each { |word| key?(word) && !exclude.include?(word) ? self[word] += 1 : self[word] = 1 }
    self
  end

  def print_dictionary(qty)
    sort { |wordx, wordy| wordy[1] <=> wordx[1] }.first(qty).each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
  end
end
