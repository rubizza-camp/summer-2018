def top_word_count(destination, raper_name, count)
  rapers = get_rapers_list destination
  check_raper_name rapers, raper_name

  config = YAML.safe_load(File.open('config.yml').read)
  no_word_array = config['excluded_words']
  word_count = {}

  rapers[raper_name].file_name.each do |file|
    text_file = File.open(destination + '/' + file)
    parse_helper text_file, word_count, no_word_array
  end
  print_top_words(word_count, count)
end

def print_top_words(words, count)
  delimeter = 1
  words.sort_by { |_k, val| -val }.each do |key, value|
    break if delimeter > count
    puts key.capitalize + ' - ' + value.to_s
    delimeter += 1
  end
end

def check_raper_name(rapers, raper_name)
  return if rapers.key? raper_name
  puts "\nРэпер #{raper_name} не судился. Осуждены следующие:\n\n"
  rapers.each { |_key, value| puts value.name }
  exit(true)
end

def parse_helper(text_file, word_count, no_word_array)
  text_file.each_line do |line|
    words = line.chomp.split(/[,\s\.?!\"«»:—;[&quot]-]+/)

    words.each do |word|
      next if word.empty? || word.length < 3
      is_word = true

      no_word_array.each { |value| is_word = false if word.downcase.eql? value }
      counter_helper(word_count, word) if is_word
    end
  end
end

def counter_helper(hash, key)
  return hash[key] += 1 if hash[key]
  hash[key] = 1
end
