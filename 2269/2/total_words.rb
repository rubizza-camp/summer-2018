# :reek:DuplicateMethodCall
# :reek:NestedIterators
# :reek:UtilityFunction
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength
def word_counter(file_path)
  words_count = 0
  words_per_round = 0
  array_round = []
  bad_words_count = 0
  bad_words_array = []
  get_bad = File.open(Dir.pwd + '/bad word dict')

  get_bad.each_line do |line|
    words = line.split
    words.each do |word|
      bad_words_array << word
    end
  end
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
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
