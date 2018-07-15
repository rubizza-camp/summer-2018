# Module for usefull methods
module FunctionalMethods
  def self.get_name(file_name)
    name = file_name.split('/').last.split('(').first.split(/ против | vs | VS | & | && /).first.strip
    name = '(Pra(Killa\'Gramm)' if name == ''
    name
  end

  def self.get_data(data, file_name)
    File.open(file_name, 'r') do |file|
      text = file.read
      text_size = text.split(/Раунд 1|Раунд 2|Раунд 3/).size
      data = create_data(data, text, text_size)
    end
    data
  end

  def self.create_data(data, text, text_size)
    data[:rounds] = get_round(text_size)
    data[:words_per_battle] = text.split(' ').size
    data[:bad_words] = count_bw(text)
    data[:text] = text
    data
  end

  def self.get_round(text_size)
    if text_size == 1
      text_size
    else
      text_size - 1
    end
  end

  def self.name_check(first, second)
    size = size_compare(first, second)
    part_size = 0
    part_size = size / 3.to_i if size > 3
    size_difference = size - part_size
    first[0..size_difference] == second[0..size_difference]
  end

  def self.size_compare(first, second)
    fsize = first.size
    ssize = second.size
    hash_size = { true => fsize, false => ssize }
    hash_size[fsize > ssize]
  end

  def self.count_bw(text)
    words = text.split(' ')
    words.count { |word| word.include? '*' } + RussianObscenity.find(text).size
  end

  def self.create_words_hash(words)
    hash_words = group_words({}, words)
    hash_words.sort_by { |word| word[1] }.reverse!
  end

  def self.group_words(hash_words, words)
    words.each do |word|
      hash_words[word] = if hash_words.key?(word)
                           hash_words[word] + 1
                         else
                           1
                         end
    end
    hash_words
  end

  def self.output_words(words, value)
    hash_words = create_words_hash(words)
    if value.zero?
      hash_words[0...30].each { |num| puts "#{num[0]} - #{num[1]} раз" }
    else
      hash_words[0...value].each { |elem| puts "#{elem[0]} - #{elem[1]} раз" }
    end
  end
end
