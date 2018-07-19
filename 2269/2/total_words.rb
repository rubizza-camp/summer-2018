def word_counter(file_path)
  words_count = 0
  words_per_round = 0
  array_round = []
  bad_words_count = 0

  config = YAML.safe_load(File.open('config.yml').read)
  bad_words_array = config['bad_words']

  file = File.open(file_path)

  file.each_line do |line|
    if line.include? 'Раунд'.downcase
      array_round << words_per_round
      words_per_round = 0
      next
    end
    words = line.split

    words.each do |word|
      word = word.gsub(/,.!?'":/, '')
      words_count += 1
      words_per_round += 1

      bad_words_array.each do |bw|
        bad_words_count += 1 if word.downcase.include? bw.downcase
      end
    end
  end
  array_round << words_per_round
  hash = { total: words_count, bad: bad_words_count, round: (array_round.sum / array_round.length) }
  hash
end
