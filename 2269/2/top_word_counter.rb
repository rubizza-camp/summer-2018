# :reek:DuplicateMethodCall
# :reek:NestedIterators
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
def top_word_count(destination, raper_name, count)
  rapers = get_rapers destination
  unless rapers.key? raper_name
    puts "\nРэпер #{raper_name} не судился. Осуждены следующие:\n\n"
    rapers.each { |_key, value| puts value.name }
    exit(true)
  end
  config = YAML.safe_load(File.open('config.yml').read)
  no_word_array = config['excluded_words']
  word_count = {}

  rapers[raper_name].file_name.each do |file|
    text_file = File.open(destination + '/' + file)

    text_file.each_line do |line|
      words = line.chomp.split(/[,\s\.?!\"«»:—;[&quot]-]+/)

      words.each do |word|
        next if word.empty? || word.length < 3
        is_word = true

        no_word_array.each do |value|
          is_word = false if word.downcase.eql? value
        end
        if is_word
          if word_count[word]
            word_count[word] += 1
          else
            word_count[word] = 1
          end
        end
      end
    end
  end
  puts "\n\n"
  delimeter = 1
  word_count.sort_by { |_k, val| -val }.each do |key, value|
    break if delimeter > count
    puts key.capitalize + ' - ' + value.to_s
    delimeter += 1
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
